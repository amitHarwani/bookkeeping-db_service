"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.saleItemProfits = exports.saleItems = exports.sales = exports.purchaseItems = exports.purchases = exports.thirdParties = exports.adjustmentTypes = exports.itemAdjustments = exports.units = exports.items = exports.userTypes = exports.defaultFeatures = exports.companyTaxMapping = exports.users = exports.userCompanyMapping = exports.taxDetails = exports.roles = exports.platformFeatures = exports.countries = exports.companies = void 0;
var companies_1 = require("./db/schema/companies");
Object.defineProperty(exports, "companies", { enumerable: true, get: function () { return companies_1.companies; } });
var countries_1 = require("./db/schema/countries");
Object.defineProperty(exports, "countries", { enumerable: true, get: function () { return countries_1.countries; } });
var platform_features_1 = require("./db/schema/platform_features");
Object.defineProperty(exports, "platformFeatures", { enumerable: true, get: function () { return platform_features_1.platformFeatures; } });
var roles_1 = require("./db/schema/roles");
Object.defineProperty(exports, "roles", { enumerable: true, get: function () { return roles_1.roles; } });
var tax_details_1 = require("./db/schema/tax_details");
Object.defineProperty(exports, "taxDetails", { enumerable: true, get: function () { return tax_details_1.taxDetails; } });
var user_company_mapping_1 = require("./db/schema/user_company_mapping");
Object.defineProperty(exports, "userCompanyMapping", { enumerable: true, get: function () { return user_company_mapping_1.userCompanyMapping; } });
var users_1 = require("./db/schema/users");
Object.defineProperty(exports, "users", { enumerable: true, get: function () { return users_1.users; } });
var company_tax_mapping_1 = require("./db/schema/company_tax_mapping");
Object.defineProperty(exports, "companyTaxMapping", { enumerable: true, get: function () { return company_tax_mapping_1.companyTaxMapping; } });
var default_features_1 = require("./db/schema/default_features");
Object.defineProperty(exports, "defaultFeatures", { enumerable: true, get: function () { return default_features_1.defaultFeatures; } });
Object.defineProperty(exports, "userTypes", { enumerable: true, get: function () { return default_features_1.userTypes; } });
var items_1 = require("./db/schema/items");
Object.defineProperty(exports, "items", { enumerable: true, get: function () { return items_1.items; } });
var units_1 = require("./db/schema/units");
Object.defineProperty(exports, "units", { enumerable: true, get: function () { return units_1.units; } });
var item_adjustments_1 = require("./db/schema/item_adjustments");
Object.defineProperty(exports, "itemAdjustments", { enumerable: true, get: function () { return item_adjustments_1.itemAdjustments; } });
Object.defineProperty(exports, "adjustmentTypes", { enumerable: true, get: function () { return item_adjustments_1.adjustmentTypes; } });
var third_parties_1 = require("./db/schema/third_parties");
Object.defineProperty(exports, "thirdParties", { enumerable: true, get: function () { return third_parties_1.thirdParties; } });
var purchases_1 = require("./db/schema/purchases");
Object.defineProperty(exports, "purchases", { enumerable: true, get: function () { return purchases_1.purchases; } });
var purchase_items_1 = require("./db/schema/purchase_items");
Object.defineProperty(exports, "purchaseItems", { enumerable: true, get: function () { return purchase_items_1.purchaseItems; } });
var sales_1 = require("./db/schema/sales");
Object.defineProperty(exports, "sales", { enumerable: true, get: function () { return sales_1.sales; } });
var sale_items_1 = require("./db/schema/sale_items");
Object.defineProperty(exports, "saleItems", { enumerable: true, get: function () { return sale_items_1.saleItems; } });
var sale_item_profits_1 = require("./db/schema/sale_item_profits");
Object.defineProperty(exports, "saleItemProfits", { enumerable: true, get: function () { return sale_item_profits_1.saleItemProfits; } });
