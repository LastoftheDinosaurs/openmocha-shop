/** @type {import('@medusajs/medusa').ConfigModule["projectConfig"]} */
export const projectConfig: import('@medusajs/medusa').ConfigModule["projectConfig"];
export const plugins: (string | {
    resolve: string;
    options: {
        upload_dir: string;
    };
} | {
    resolve: string;
    /** @type {import('@medusa-plugin-wishlist').PluginOptions} */
    options?: undefined;
} | {
    resolve: string;
    /** @type {import('@medusajs/admin').PluginOptions} */
    options?: undefined;
} | {
    resolve: string;
    /** @type {import('@medusajs/admin').PluginOptions} */
    options: import('@medusajs/admin').PluginOptions;
})[];
export const modules: {};
