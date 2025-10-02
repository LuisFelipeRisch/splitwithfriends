document.addEventListener("turbo:load", () => {
  const toastElList = document.querySelectorAll(".toast")
  toastElList.forEach((toastEl) => {
    const toast = new bootstrap.Toast(toastEl)
    toast.show()
  })
})
