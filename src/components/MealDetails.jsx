import React from "react";

function MealDetails({ meal, onCloseRecipe }) {
  return (
    <div className="meal-details-content">
      <h2 className="recipe-title">{meal.name}</h2>
      <p className="recipe-category">{meal.notes}</p>
      <div className="recipe-instruct">
        <h3>Ingredient</h3>
        <ol>

        {meal.ingredients.map(item => (
          <li key={item.id}>{item.name}</li>
          ))}
          </ol>
      </div>
      <div className="recipe-instruct">
        <h3>Instructions</h3>
        {meal.instructions.map(item => (
          <p key={item.id}>{item.content}</p>
        ))}
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
