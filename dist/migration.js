"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const postgres_js_1 = require("drizzle-orm/postgres-js");
const migrator_1 = require("drizzle-orm/postgres-js/migrator");
const postgres_1 = __importDefault(require("postgres"));
const dotenv_1 = __importDefault(require("dotenv"));
const fs_1 = __importDefault(require("fs"));
dotenv_1.default.config();
dotenv_1.default.config({ path: `.env.${process.env.NODE_ENV}` });
// for migrations
function main() {
    return __awaiter(this, void 0, void 0, function* () {
        /* DB url from file or enviornment variable */
        const DB_URL = (process.env.DB_URL ||
            fs_1.default.readFileSync(process.env.DB_URL_FILE, "utf-8"));
        const migrationClient = (0, postgres_1.default)(DB_URL, { max: 1 });
        yield (0, migrator_1.migrate)((0, postgres_js_1.drizzle)(migrationClient), {
            migrationsFolder: "./db/migrations",
        });
        yield migrationClient.end();
    });
}
main();
