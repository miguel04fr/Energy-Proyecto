document.addEventListener("DOMContentLoaded", () => {
    const toggleButton = document.getElementById("toggleMode")
  const body = document.body


  // Carrusel
  const carousel = document.querySelector(".carousel")
  const carouselItems = document.querySelectorAll(".carousel-item")
  const prevBtn = document.getElementById("prevBtn")
  const nextBtn = document.getElementById("nextBtn")
  const indicators = document.querySelectorAll(".indicator")
  let currentIndex = 0

  // Inicializar carrusel
  function showSlide(index) {
    // Ocultar todos los slides
    carouselItems.forEach((item) => {
      item.classList.remove("active")
    })

    // Actualizar indicadores
    indicators.forEach((indicator) => {
      indicator.classList.remove("active")
    })

    // Mostrar el slide actual
    carouselItems[index].classList.add("active")
    indicators[index].classList.add("active")
  }

  // Siguiente slide
  function nextSlide() {
    currentIndex = (currentIndex + 1) % carouselItems.length
    showSlide(currentIndex)
  }

  // Slide anterior
  function prevSlide() {
    currentIndex = (currentIndex - 1 + carouselItems.length) % carouselItems.length
    showSlide(currentIndex)
  }

  // Event listeners para los botones
  nextBtn.addEventListener("click", nextSlide)
  prevBtn.addEventListener("click", prevSlide)

  // Event listeners para los indicadores
  indicators.forEach((indicator, index) => {
    indicator.addEventListener("click", () => {
      currentIndex = index
      showSlide(currentIndex)
    })
  })

  // Auto-play del carrusel
  let interval = setInterval(nextSlide, 5000)

  // Pausar auto-play cuando el mouse está sobre el carrusel
  carousel.addEventListener("mouseenter", () => {
    clearInterval(interval)
  })

  // Reanudar auto-play cuando el mouse sale del carrusel
  carousel.addEventListener("mouseleave", () => {
    interval = setInterval(nextSlide, 5000)
  })

  // Botones de deportes
  const sportButtons = document.querySelectorAll(".sport-btn")
  const selectedSportInput = document.getElementById("selectedSport")

  sportButtons.forEach((button) => {
    button.addEventListener("click", function () {
      // Quitar selección previa
      sportButtons.forEach((btn) => {
        btn.classList.remove("selected")
      })

      // Marcar como seleccionado
      this.classList.add("selected")

      // Guardar el deporte seleccionado en el input hidden
      selectedSportInput.value = this.getAttribute("data-sport")

      // Animación de selección
      const card = this.closest(".sport-card")
      card.style.animation = "pulse 0.5s ease-in-out"

      setTimeout(() => {
        card.style.animation = ""
      }, 500)

      // Scroll suave hasta los botones de acción
      document.querySelector(".form-actions").scrollIntoView({
        behavior: "smooth",
        block: "center",
      })
    })
  })

  // Validación del formulario
  const sportsForm = document.getElementById("sportsForm")

  sportsForm.addEventListener("submit", (event) => {
    if (selectedSportInput.value === "") {
      event.preventDefault()

      // Crear notificación de error
      const notification = document.createElement("div")
      notification.className = "notification error"
      notification.innerHTML = `
                <i class="fas fa-exclamation-circle"></i>
                <span>Por favor, selecciona un deporte antes de continuar.</span>
            `

      document.body.appendChild(notification)

      // Mostrar y ocultar notificación
      setTimeout(() => {
        notification.classList.add("show")
      }, 100)

      setTimeout(() => {
        notification.classList.remove("show")
        setTimeout(() => {
          notification.remove()
        }, 500)
      }, 3000)

      // Scroll hasta la sección de deportes
      document.getElementById("sports-section").scrollIntoView({
        behavior: "smooth",
      })
    }
  })

  // Animación de elementos al hacer scroll
  const animateOnScroll = () => {
    const elements = document.querySelectorAll(".section-header, .sport-card, .form-actions")

    elements.forEach((element) => {
      const elementPosition = element.getBoundingClientRect().top
      const screenPosition = window.innerHeight / 1.3

      if (elementPosition < screenPosition) {
        element.style.opacity = "1"
        element.style.transform = "translateY(0)"
      }
    })
  }

  // Inicializar animaciones
  window.addEventListener("scroll", animateOnScroll)
  animateOnScroll() // Ejecutar una vez al cargar la página

  // Efecto de parallax en el hero banner
  window.addEventListener("scroll", () => {
    const scrollPosition = window.pageYOffset
    const heroBanner = document.querySelector(".hero-banner")

    if (heroBanner) {
      heroBanner.style.backgroundPosition = `center ${scrollPosition * 0.5}px`
    }
  })

  // Navegación suave para enlaces internos
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener("click", function (e) {
      e.preventDefault()

      const targetId = this.getAttribute("href")
      if (targetId === "#") return

      const targetElement = document.querySelector(targetId)
      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: "smooth",
        })
      }
    })
  })

  // Añadir estilos CSS adicionales para animaciones
  const style = document.createElement("style")
  style.textContent = `
        .section-header, .sport-card, .form-actions {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.8s ease, transform 0.8s ease;
        }
        
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            background-color: white;
            color: var(--dark);
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
            z-index: 1000;
            transform: translateX(120%);
            transition: transform 0.3s ease;
        }
        
        .notification.show {
            transform: translateX(0);
        }
        
        .notification.error i {
            color: var(--danger);
            font-size: 1.2rem;
        }
    `
  document.head.appendChild(style)
// Funcionalidad de modales
const loginBtn = document.getElementById("loginBtn");
const registerBtn = document.getElementById("registerBtn");
const loginModal = document.getElementById("loginModal");
const registerModal = document.getElementById("registerModal");
const modalOverlay = document.getElementById("modalOverlay");
const closeButtons = document.querySelectorAll(".close-modal");
const switchToRegister = document.getElementById("switchToRegister");
const switchToLogin = document.getElementById("switchToLogin");

// Función para abrir modal
function openModal(modal) {
  modal.style.display = "block";
  modalOverlay.style.display = "block";
  document.body.style.overflow = "hidden"; // Prevenir scroll
}

// Función para cerrar modal
function closeModal(modal) {
  modal.style.display = "none";
  modalOverlay.style.display = "none";
  document.body.style.overflow = ""; // Restaurar scroll
}

// Abrir modales
loginBtn.addEventListener("click", () => openModal(loginModal));
registerBtn.addEventListener("click", () => openModal(registerModal));

// Cerrar modales con botón X
closeButtons.forEach((button) => {
  button.addEventListener("click", () => {
    closeModal(document.getElementById(button.getAttribute("data-modal")));
  });
});

// Cerrar modales al hacer clic fuera
modalOverlay.addEventListener("click", () => {
  closeModal(loginModal);
  closeModal(registerModal);
});

// Cambiar entre modales
switchToRegister.addEventListener("click", () => {
  closeModal(loginModal);
  openModal(registerModal);
});

switchToLogin.addEventListener("click", () => {
  closeModal(registerModal);
  openModal(loginModal);
});

// Mostrar/ocultar contraseña
const togglePasswordButtons = document.querySelectorAll(".toggle-password");
togglePasswordButtons.forEach((button) => {
  button.addEventListener("click", () => {
    const passwordInput = button.previousElementSibling;
    const icon = button.querySelector("i");
    passwordInput.type = passwordInput.type === "password" ? "text" : "password";
    icon.classList.toggle("fa-eye");
    icon.classList.toggle("fa-eye-slash");
  });
});

})

