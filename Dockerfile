# Étape de construction
FROM node:18-alpine AS builder

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN yarn install

# Copier le reste des fichiers du projet
COPY . .

# Construire le projet Nuxt.js
RUN yarn  build


# Exposer le port 3000
EXPOSE 3000

# Commande de démarrage
CMD ["yarn", "dev"]

