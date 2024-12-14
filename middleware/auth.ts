export default defineNuxtRouteMiddleware((to, from) => {
    if (process.client) { // Vérifier si le code s'exécute côté client
        const token = localStorage.getItem('token');
        if (!token) {
          return navigateTo('/');
        }
      }
})