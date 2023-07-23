import React from "react";

function MealDetails({ meal, onCloseRecipe }) {
  return (
    <div className="meal-details-content">
      <h2 className="recipe-title">{meal.strMeal}</h2>
      <p className="recipe-category">{meal.strCategory}</p>
      <div className="recipe-instruct">
        <h3>Instructions</h3>
        <p>{meal.strInstructions}</p>
      </div>
      <div className="recipe-meal-img">
        <img src={meal.strMealThumb} alt="food" />
      </div>
      <div className="recipe-link">
        <a href={meal.strYoutube} target="_blank" rel="noopener noreferrer">
          Watch Video
        </a>
      </div>
      <button id="recipe-close-btn" onClick={onCloseRecipe}>
        Close Recipe
      </button>
    </div>
  );
}

export default MealDetails;