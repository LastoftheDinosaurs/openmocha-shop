# OpenMocha Shop

This project is built with [MedusaJS](https://medusajs.com/), a headless commerce engine. Follow the steps below to set up the backend and storefront environments.

## Prerequisites

Ensure that the following are preinstalled on your system:

- [Docker](https://www.docker.com/get-started)
- [npm](https://www.npmjs.com/get-npm)

---

## Installation Steps

### 1. Clone the Repository

Start by cloning the repository and navigating into the project directory:

```bash
git clone https://github.com/LastoftheDinosaurs/openmocha-shop.git
cd openmocha-shop
```

### 2. Start PostgreSQL and Redis Containers (Optional)

To run the backend services such as PostgreSQL and Redis, use Docker:

```bash
cp .env.example .env
docker compose up -d
```

---

## Backend Setup

### 1. Navigate to the Backend Directory

Move into the backend directory and install the necessary dependencies:

```bash
cd openmocha
cp .env.example .env
npm install
```

### 2. Seed the Database (Optional)

If you need to populate the database with initial data, run the seed script:

```bash
npm run seed
```

### 3. Start the Development Server

Once the dependencies are installed and the database is set up, start the development server:

```bash
npm run dev
```

---

## Storefront Setup

### 1. Navigate to the Storefront Directory

Move into the storefront directory and install its dependencies:

```bash
cd openmocha-storefront
cp .env.example .env
npm install
```

### 2. Start the Development Server

Once dependencies are installed, start the storefront's development server:

```bash
npm run dev
```

---

## Additional Notes

- Ensure that `.env` files are correctly set up in both the backend and storefront directories.
- If needed, customize the environment variables to suit your development environment.
- For more detailed documentation, check the [MedusaJS documentation](https://docs.medusajs.com).
