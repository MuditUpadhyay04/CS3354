
import java.util.Arrays;
import java.util.List;


public class WorkoutPlan {


    private static final List<String> validSplits = Arrays.asList("Push/Pull/Legs", "Bro", "Upper/Lower");


    private static final List<String> validExercises = Arrays.asList(
            // Chest
            "Bench Press", "Incline Bench Press", "Decline Bench Press", "Dumbbell Flyes", "Cable Flyes", "Dips",
            // Biceps
            "Bicep Curl", "Hammer Curl", "Concentration Curl", "Cable Curl", "Preacher Curl", "Chin-Ups",
            // Triceps
            "Triceps Extension", "Close-Grip Bench Press", "Overhead Triceps Extension", "Cable Pushdown", "Skullcrusher", "Diamond Push-Ups",
            // Back
            "Pull-Up", "Lat Pulldown", "Barbell Row", "Dumbbell Row", "Cable Row", "Seated Cable Row",
            // Shoulders
            "Overhead Press", "Lateral Raise", "Front Raise", "Rear Delt Fly", "Arnold Press", "Shrugs",
            // Legs
            "Squat", "Leg Press", "Leg Extension", "Hamstring Curl", "Calf Raise", "Lunge"
    );


    public static String createWorkoutPlan(String selectedSplit, List<String> selectedExercises) {
        if (selectedSplit == null || selectedSplit.isEmpty()) {
            return "Split cannot be null or empty.";
        }


        if (!validSplits.contains(selectedSplit)) {
            return "Invalid split. Please choose from: " + validSplits;
        }


        if (selectedExercises == null || selectedExercises.isEmpty()) {
            return "Exercises cannot be null or empty.";
        }


        for (String exercise : selectedExercises) {
            if (!validExercises.contains(exercise)) {
                return "Invalid exercise(s) detected. Please choose valid exercises.";
            }
        }


        return "Workout plan created successfully!";
    }
}
