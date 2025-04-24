// Import the Firebase SDKs
import firebase from "firebase/app"
import "firebase/auth"
import "firebase/firestore"

// Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAoxhhGHGu_FIbuTJ9UNxpsKofSd7HOdp8",
  authDomain: "mygymbro-3f8d2.firebaseapp.com",
  projectId: "mygymbro-3f8d2",
  storageBucket: "mygymbro-3f8d2.firebasestorage.app",
  messagingSenderId: "789900020245",
  appId: "1:789900020245:web:62701b5a125ce167af5c1c",
  measurementId: "G-WMEHFGH34L",
}

// Initialize Firebase
if (!firebase.apps.length) {
  firebase.initializeApp(firebaseConfig)
}

// Initialize Firestore
const db = firebase.firestore()

// Get current user
function getCurrentUser() {
  return new Promise((resolve, reject) => {
    const unsubscribe = firebase.auth().onAuthStateChanged((user) => {
      unsubscribe()
      resolve(user)
    }, reject)
  })
}

// Save data to Firestore
async function saveToFirestore(collection, data) {
  try {
    const user = await getCurrentUser()
    if (!user) {
      console.error("No user logged in")
      return { success: false, error: "No user logged in" }
    }

    // Add user ID to the data
    const dataWithUser = {
      ...data,
      userId: user.uid,
      createdAt: firebase.firestore.FieldValue.serverTimestamp(),
    }

    // Add document to collection
    const docRef = await db.collection(collection).add(dataWithUser)
    console.log("Document written with ID: ", docRef.id)
    return { success: true, docId: docRef.id }
  } catch (error) {
    console.error("Error adding document: ", error)
    return { success: false, error: error.message }
  }
}

// Get user data from Firestore
async function getUserData(collection) {
  try {
    const user = await getCurrentUser()
    if (!user) {
      console.error("No user logged in")
      return { success: false, error: "No user logged in" }
    }

    // Query documents for current user
    const snapshot = await db.collection(collection).where("userId", "==", user.uid).orderBy("createdAt", "desc").get()

    const data = []
    snapshot.forEach((doc) => {
      data.push({
        id: doc.id,
        ...doc.data(),
      })
    })

    return { success: true, data }
  } catch (error) {
    console.error("Error getting documents: ", error)
    return { success: false, error: error.message }
  }
}
