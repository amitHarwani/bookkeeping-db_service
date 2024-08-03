

export interface CompanyTaxDetails {
    taxId: number,
    countryId: number,
    taxName: string,
    taxPercentage: number,
    taxNickName: string,
    isTaxOnInvoice: boolean,
    isRegistrationOptional: boolean
}