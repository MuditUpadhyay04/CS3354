
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;


class NutritionTracker_UseCase_Testing {


    @Test
    void trackNutrition_TC1() {
        // Valid diet plan (bulking) and valid calories
        assertEquals("Nutrition tracked successfully!", NutritionTracker.trackNutrition("Keto(B)", 3000));
    }


    @Test
    void trackNutrition_TC2() {
        // Valid diet plan and invalid calories (out of range)
        assertEquals("Invalid calorie range for bulking. Please enter a value between 2500-4000.", NutritionTracker.trackNutrition("Keto(B)", 2000));
    }


    @Test
    void trackNutrition_TC3() {
        // Valid diet plan and exceptional calories
        assertEquals("Calories cannot be null.", NutritionTracker.trackNutrition("Keto(B)", null));
    }


    @Test
    void trackNutrition_TC4() {
        // Invalid diet plan and valid calories
        assertEquals("Invalid diet plan. Please choose from: [Keto(B), Paleo(B), Vegan(B), Carnivore(B), Mediterranean(B), Keto(C), Paleo(C), Vegan(C), Carnivore(C), Mediterranean(C)]", NutritionTracker.trackNutrition("InvalidDiet", 3000));
    }


    @Test
    void trackNutrition_TC5() {
        // Exceptional diet plan and valid calories
        assertEquals("Diet plan cannot be null or empty.", NutritionTracker.trackNutrition(null, 3000));
    }
}
