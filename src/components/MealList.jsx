import React from "react";

function MealList({ meals, onRecipeBtnClick }) {
  return (
    <div className="meal-list">
      {meals.map((meal) => (
        <div key={meal.idMeal} className="meal-item">
          <div className="meal-img">
            <img src={meal.str_meal_thumb} alt={meal.name} />
          </div>
          <div className="meal-name">
            <h3>{meal.strMeal}</h3>
            <button
              className="recipe-btn noise_btn--bg"
              onClick={() => onRecipeBtnClick(meal)}
            >
              Get Recipe
            </button>
          </div>
        </div>
      ))}
    </div>
  );
}

export default MealList;
