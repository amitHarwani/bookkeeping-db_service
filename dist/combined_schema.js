"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.users = exports.userCompanyMapping = exports.taxDetails = exports.roles = exports.platformFeaturesEnum = exports.platformFeatures = exports.countries = exports.companies = void 0;
var companies_1 = require("./db/schema/companies");
Object.defineProperty(exports, "companies", { enumerable: true, get: function () { return companies_1.companies; } });
var countries_1 = require("./db/schema/countries");
Object.defineProperty(exports, "countries", { enumerable: true, get: function () { return countries_1.countries; } });
var platform_features_1 = require("./db/schema/platform_features");
Object.defineProperty(exports, "platformFeatures", { enumerable: true, get: function () { return platform_features_1.platformFeatures; } });
Object.defineProperty(exports, "platformFeaturesEnum", { enumerable: true, get: function () { return platform_features_1.platformFeaturesEnum; } });
var roles_1 = require("./db/schema/roles");
Object.defineProperty(exports, "roles", { enumerable: true, get: function () { return roles_1.roles; } });
var tax_details_1 = require("./db/schema/tax_details");
Object.defineProperty(exports, "taxDetails", { enumerable: true, get: function () { return tax_details_1.taxDetails; } });
var user_company_mapping_1 = require("./db/schema/user_company_mapping");
Object.defineProperty(exports, "userCompanyMapping", { enumerable: true, get: function () { return user_company_mapping_1.userCompanyMapping; } });
var users_1 = require("./db/schema/users");
Object.defineProperty(exports, "users", { enumerable: true, get: function () { return users_1.users; } });