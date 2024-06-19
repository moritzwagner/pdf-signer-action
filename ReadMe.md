# PDF Signer Action

This action signs a given PDF file using a provided certificate.

## Inputs

- `pdf_file`: The path to the PDF file to be signed.
- `certificate`: The base64 encoded certificate from a p12 certificate file. You can use the following command to encode the    certificate:
    ```bash
    base64 -i your-certificate.p12
    ```
  or
    ```bash
    openssl base64 -in your-certificate.p12 -out your-certificate.base64
    ```
  Make sure to add the output to your repository secrets and use it in the workflow file as shown in the example below
- `cert_password`: The password for the certificate.

## Outputs

- `signed_pdf`: The path to the signed PDF file.

## Example Usage

```yaml
name: Sign PDF
on: [push]

jobs:
  sign:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2
      - name: Sign the PDF
        uses: moritzwagner/pdf-signer-action@v1
        with:
          pdf_file: 'path/to/your.pdf'
          certificate: ${{ secrets.CERTIFICATE }}
          cert_password: ${{ secrets.CERT_PASSWORD }}
      - name: Upload signed PDF
        uses: actions/upload-artifact@v2
        with:
          name: signed-pdf
          path: ${{ steps.sign.outputs.signed_pdf }}
