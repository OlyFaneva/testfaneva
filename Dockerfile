# Étape de construction
FROM node:18-alpine AS builder

# Définir le répertoire de travail
WORKDIR /app

# Ajouter un groupe et un utilisateur non-root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN yarn install

# Copier le reste des fichiers du projet
COPY . .

# Construire le projet Nuxt.js
RUN yarn build

# Changer ny permissions mba hahafahan'ilay utilisateur non-root miasa
RUN chown -R appuser:appgroup /app

# Manondro ny mpampiasa hampiasa ny container
USER appuser

# Exposer le port 3000
EXPOSE 3000

# Commande de démarrage
CMD ["yarn", "dev"]
