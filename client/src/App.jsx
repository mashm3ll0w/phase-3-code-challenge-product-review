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
    <div className="App">
      <div className="search-container">
        <input
          type="text"
          id="search-input"
          value={searchInputText}
          onChange={handleInputChange}
        />
        <button id="search-btn" onClick={handleSearchClick}>
          Search
        </button>
      </div>
      {notFound ? (
        <p>Sorry, no recipe was found with the specified ingredient</p>
      ) : (
        <MealList meals={meals} onRecipeBtnClick={handleRecipeBtnClick} />
      )}
      {selectedMeal && (
        <MealDetails meal={selectedMeal} onCloseRecipe={handleCloseRecipe} />
      )}
    </div>
  );
}

export default App;