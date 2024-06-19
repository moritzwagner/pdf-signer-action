#!/bin/sh

set -e

PDF_FILE=$1
CERTIFICATE=$2
CERT_PASSWORD=$3

# Convert the base64 encoded certificate to a .p12 file
echo "$CERTIFICATE" > cert.blob
base64 --decode cert.blob > cert.p12

# Write the certificate password to a file
echo "$CERT_PASSWORD" > cert_password.txt

# Add a signature field to the PDF
pyhanko sign addfields --field 1/50,50,300,100/Name "$PDF_FILE" main_signatureField.pdf

# Sign the PDF
pyhanko sign addsig --reason AutomaticallySignedByCiWorkflow pkcs12 main_signatureField.pdf signed.pdf cert.p12 --passfile cert_password.txt

# Clean up temporary files
rm cert.p12 cert_password.txt cert.blob

# Print completion message
echo "Signed PDF created: signed.pdf"
