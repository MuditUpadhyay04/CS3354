import java.util.Arrays;
import java.util.List;


public class NutritionTracker {


    private static final List<String> validDietPlans = Arrays.asList(
            "Keto(B)", "Paleo(B)", "Vegan(B)", "Carnivore(B)", "Mediterranean(B)",
            "Keto(C)", "Paleo(C)", "Vegan(C)", "Carnivore(C)", "Mediterranean(C)"
    );


    public static String trackNutrition(String dietPlan, Object calories) {
        if (dietPlan == null || dietPlan.isEmpty()) {
            return "Diet plan cannot be null or empty.";
        }


        if (!validDietPlans.contains(dietPlan)) {
            return "Invalid diet plan. Please choose from: " + validDietPlans;
        }


        if (calories == null) {
            return "Calories cannot be null.";
        }


        try {
            int calorieInt = Integer.parseInt(calories.toString());


            if (dietPlan.contains("(B)")) {
                if (calorieInt < 2500 || calorieInt > 4000) {
                    return "Invalid calorie range for bulking. Please enter a value between 2500-4000.";
                }
            } else if (dietPlan.contains("(C)")) {
                if (calorieInt < 1000 || calorieInt > 2500) {
                    return "Invalid calorie range for cutting. Please enter a value between 1000-2500.";
                }
            }


            return "Nutrition tracked successfully!";


        } catch (NumberFormatException e) {
            return "Invalid calorie input. Please enter a valid integer.";
        }
    }
}


