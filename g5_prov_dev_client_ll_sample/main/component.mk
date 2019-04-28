#
# Main component makefile.
#
# This Makefile can be left empty. By default, it will take the sources in the 
# src/ directory, compile them and link them into lib(subdirectory_name).a 
# in the build directory. This behaviour is entirely configurable,
# please read the ESP-IDF documents if you need to do this.
#
COMPONENT_EMBED_TXTFILES := certs/leaf_private_key.pem certs/leaf_certificate.der

ifndef IDF_CI_BUILD
# Print an error if the certificate/key files are missing
$(COMPONENT_PATH)/certs/leaf_private_key.pem $(COMPONENT_PATH)/certs/leaf_certificate.der:
	@echo "Missing PEM file $@. This file identifies the ESP32 to Azure DPS for the example, see README for details."
	exit 1
else  # IDF_CI_BUILD
# this case is for the internal Continuous Integration build which
# compiles all examples. Add some dummy certs so the example can
# compile (even though it won't work)
$(COMPONENT_PATH)/certs/leaf_private_key.pem $(COMPONENT_PATH)/certs/leaf_certificate.der:
	echo "Dummy certificate data for continuous integration" > $@
endif

CFLAGS += -DSET_TRUSTED_CERT_IN_SAMPLES
