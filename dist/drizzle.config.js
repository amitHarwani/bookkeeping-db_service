"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const drizzle_kit_1 = require("drizzle-kit");
const dotenv_1 = __importDefault(require("dotenv"));
const fs_1 = __importDefault(require("fs"));
dotenv_1.default.config();
dotenv_1.default.config({ path: `.env.${process.env.NODE_ENV}` });
let DB_PASSWORD = "";
try {
    /* Password from file or enviornment variable */
    DB_PASSWORD = process.env.DB_PASSWORD || fs_1.default.readFileSync(process.env.DB_PASSWORD_FILE || "", 'utf-8');
}
catch (err) {
    console.log("DB_PASSWORD NOT FOUND, IGNORE IF BUILDING DOCKER IMAGE");
}
exports.default = (0, drizzle_kit_1.defineConfig)({
    schema: './db/schema',
    out: './db/migrations',
    dialect: 'postgresql',
    dbCredentials: {
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: DB_PASSWORD,
        database: process.env.DB_NAME,
    },
});
