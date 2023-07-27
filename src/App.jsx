import React, { useState } from "react";
import MealList from "./components/MealList";
import MealDetails from "./components/MealDetails";


function App() {
  const [searchInputText, setSearchInputText] = useState("");
  const [meals, setMeals] = useState([]);
  const [notFound, setNotFound] = useState(false);
  const [selectedMeal, setSelectedMeal] = useState(null);
  const [notes, setNotes] = useState("");

  const handleInputChange = (e) => {
    setSearchInputText(e.target.value);
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
    fetch(`/recipes?ingredient=${searchInputText}`)
      .then((res) => res.json())
      .then((data) => {
        if (data.length > 0) {
          setMeals(data);
          setNotFound(false);
        } else {
          setMeals([]);
          setNotFound(true);
        }
      });
  };

  const handleSaveFavorite = (recipeId) => {
    fetch(`/recipes/${recipeId}/favorites`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
      body: JSON.stringify({
        recipeId: recipeId
      })
    })
    .then((res) => res.json())
    .then((data) => {
      console.log(data);
    })
    .catch((error) => {
      console.error("Error saving recipe as favorite:", error);
    });
  };

  const handleUpdateNotes = (recipeId, notes) => {
    fetch(`/recipes/${recipeId}/notes`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({notes}),
    })
    .catch((error) => {
      console.error("Error updating notes:", error);
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
            {selectedMeal && (
            <button className="recipe-btn noise_btn--bg" onClick={() => handleSaveFavorite(selectedMeal.id)}>
              Save as Favorite
            </button>
          )}
          {selectedMeal && (
            <div>
              <h3>Notes:</h3>
              <textarea
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
              />
              <button className="recipe-btn noise_btn--bg" onClick={() => handleUpdateNotes(selectedMeal.id, notes)}>
                Update Notes
              </button>
            </div>
          )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
