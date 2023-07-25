import React, { useState } from "react";
import MealList from "./components/MealList";
import MealDetails from "./components/MealDetails";


function App() {
  const [searchInputText, setSearchInputText] = useState("");
  const [meals, setMeals] = useState([]);
  const [notFound, setNotFound] = useState(false);
  const [selectedMeal, setSelectedMeal] = useState(null);

  const handleInputChange = (e) => {
    setSearchInputText(e.target.value.trim());
  };

  const handleSearchClick = () => {
    fetchMeals();
  };

  const handleRecipeBtnClick = (meal) => {
    setSelectedMeal(meal);
  };

  const handleCloseRecipe = () => {
    setSelectedMeal(null);
  };

  const fetchMeals = () => {
    console.log(searchInputText);
    fetch(`/recipes?ingredient=${searchInputText}`)
      .then((res) => res.json())
      .then((data) => {
        if (data.meals) {
          setMeals(data.meals);
          setNotFound(false);
        } else {
          setMeals([]);
          setNotFound(true);
        }
      });
  };

  return (
    <div className="container">
      <div className="wrap-meal">
        <div className="search-meal">
          <h2 className="title">Search For Recipe's From Your Ingredients</h2>
          <div className="search-meal-box">
            <input
              type="text"
              className="search-content"
              placeholder="Enter an Ingredient"
              value={searchInputText}
              onChange={handleInputChange}
            />
            <button type="submit" className="btn search-btn" onClick={handleSearchClick}>
              <i className="fas fa-search"></i>
            </button>
          </div>
        </div>

        <div className="meal-result">
          <h2 className="title">Recipe Ideas Results:</h2>
          <div id="meal">
            {notFound ? (
              <p>Sorry, no recipe was found with the specified ingredient</p>
            ) : (
              <MealList meals={meals} onRecipeBtnClick={handleRecipeBtnClick} />
            )}
            {selectedMeal && (
              <MealDetails meal={selectedMeal} onCloseRecipe={handleCloseRecipe} />
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;