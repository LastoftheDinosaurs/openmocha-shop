This project sets up a MedusaJS backend and a Node.js storefront using various methods, including NixOS, Docker, and direct command-line execution. Follow the instructions below to get started quickly.

## Prerequisites

Ensure you have the following tools installed:

- **Node.js (v18.x)**: Required to run MedusaJS.
- **Git**: For version control.
- **PostgreSQL**: The database used by MedusaJS.
- **Redis**: Used for event queues and caching.
- **Docker**: If you prefer containerized deployment.
- **Podman** (if using NixOS setup).

## Setup Options

### Copy Environment File

Before starting with any setup method, ensure that you copy the `.env.example` file to `.env`. The default settings should work without modification, but you can change the default passwords if needed:

```bash
cp .env.example .env
```

### 1. Quickstart with Docker Compose

The simplest way to start the project is using Docker Compose. This method automatically starts PostgreSQL and Redis.

#### Steps:

1. **Start PostgreSQL and Redis**: In the project root, run:

   ```bash
   docker compose up -d
   ```

   This command will start PostgreSQL and Redis, as defined in the `docker-compose.yml` file.

### 2. Using Nix Shell for Development Environment

Running `nix-shell` in the project root sets up a complete development environment with Node.js 18.x, PostgreSQL, Redis, and other dependencies configured via `default.nix`.

#### Steps:

1. Execute `nix-shell` in the terminal to start the shell environment.
2. To start the backend services, ensure Podman is running and use the configured `podman-compose` setup as outlined in the `shellHook` of `default.nix`.

### 3. Manually Setting Up the Environment

If you prefer managing the development environment manually, ensure that PostgreSQL and Redis services are running on your system. You can start them using their respective commands or through your OS's service management tools.

## Running the Medusa Backend

After setting up PostgreSQL and Redis, follow these steps to start the Medusa backend:

1. **Navigate to the Backend Directory**:

   ```bash
   cd openmocha
   ```

2. **Install Dependencies**:

   ```bash
   npm install
   ```

3. **Build the Project**:

   ```bash
   npm run build
   ```

4. **Start the Backend**:

   ```bash
   npm run start
   ```

## Running the Storefront

To start the storefront, follow these steps:

1. **Navigate to the Storefront Directory**:

   ```bash
   cd openmocha-storefront
   ```

2. **Install Dependencies**:

   ```bash
   npm install
   ```

3. **Start the Storefront**:

   ```bash
   npm run start
   ```

## Using the Medusa CLI

To manage Medusa-specific tasks, install the Medusa CLI:

```bash
npm install @medusajs/medusa-cli -g
```

You can then run commands such as:

- **Start Medusa**:

  ```bash
  medusa develop
  ```

- **Audit Dependencies**:

  ```bash
  npm audit
  ```

- **Install Packages**:

  ```bash
  npm install
  ```

## Troubleshooting

- **Common Installation Issues**: Ensure PostgreSQL and Redis are running before starting Medusa.
- **Permissions Errors**: Resolve file permissions by adjusting user access settings on your system.

For more details on setting up a MedusaJS project, refer to the official [Medusa documentation](https://docs.medusajs.com).

## Getting Started with MedusaJS

### Creating an Admin User

After setting up the backend, you need to create an admin user to access the admin dashboard. If you used the `seed` command to populate your database, the default admin credentials will be:

- **Email**: `admin@medusa-test.com`
- **Password**: `supersecret`

To create a new admin user with custom credentials, run:

```bash
npx medusa user -e your-email@example.com -p yourpassword
```

### Populating the Site with Sample Data

Populate your Medusa site with demo data using the seeding command:

```bash
npx @medusajs/medusa-cli@latest seed -f ./data/seed.json
```

This will create sample products, regions, and other demo data necessary for a complete setup.

### Using Medusa Plugins

Medusa supports various plugins to extend functionality, such as:

1. **Payment Plugins**: Supports Stripe, PayPal, and more.
2. **Fulfillment Plugins**: For handling order fulfillment.
3. **Custom Plugins**: Extend Medusa’s functionality based on specific needs.

Install plugins using:

```bash
yarn add @medusajs/<plugin-name>
```

Configure the plugin in your backend’s `medusa-config.js` under the plugins section.

## Accessing the Site

After setting up the Medusa backend and storefront, you can access the following endpoints:

### 1. Access the Admin Dashboard

The Medusa Admin Dashboard allows you to manage products, orders, and other store settings. By default, it's hosted on `localhost:9000` if you haven't configured a separate admin frontend.

- **URL**: [http://localhost:9000/admin](http://localhost:9000/admin)
- **Login**: Use the admin credentials you created (`admin@medusa-test.com` / `supersecret`, or your custom credentials).

### 2. Access the Storefront

The Storefront is where customers can browse and purchase products. It is usually hosted on a separate port from the backend.

- **URL**: [http://localhost:8000](http://localhost:8000)
- This endpoint will display the main storefront where users can explore products and make purchases.

### 3. API Endpoints

Medusa also exposes several API endpoints that you can use to interact programmatically with the backend. Here are some commonly used endpoints:

- **Get Products**: [http://localhost:9000/store/products](http://localhost:9000/store/products) - Retrieves a list of available products.
- **Get Orders**: [http://localhost:9000/store/orders](http://localhost:9000/store/orders) - Retrieves customer orders. Requires authentication.
- **Admin Endpoints**: Use [http://localhost:9000/admin/*](http://localhost:9000/admin/*) for managing the store, products, and other admin functionalities.

### Testing the Setup

To verify the backend is working correctly, you can test a simple API call to fetch products:

```bash
curl http://localhost:9000/store/products
```
