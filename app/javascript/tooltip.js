function initializeTooltips() {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]:not([data-bs-initialized])');
  tooltipTriggerList.forEach(tooltipTriggerEl => {
    new bootstrap.Tooltip(tooltipTriggerEl);
    tooltipTriggerEl.setAttribute('data-bs-initialized', 'true');
  });
}

const observer = new MutationObserver((mutations) => {
  initializeTooltips();
});

observer.observe(document.body, {
  childList: true,
  subtree: true
});