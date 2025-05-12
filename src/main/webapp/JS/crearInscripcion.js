/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener("DOMContentLoaded", () => {
  const toggleButton = document.getElementById("toggleMode")
  const body = document.body

  // Check if user previously selected dark mode
  const isDarkMode = localStorage.getItem("darkMode") === "true"

  // Apply dark mode if previously selected
  if (isDarkMode) {
    body.classList.add("dark-mode")
    toggleButton.textContent = "Modo Claro"
  }

  // Toggle dark/light mode
  toggleButton.addEventListener("click", () => {
    body.classList.toggle("dark-mode")

    const isDark = body.classList.contains("dark-mode")
    localStorage.setItem("darkMode", isDark)

    toggleButton.textContent = isDark ? "Modo Claro" : "Modo Oscuro"
  })
})

