# HDF5

## What it is
Think of HDF5 like a filing cabinet inside a filing cabinet — folders within folders, each drawer holding massive datasets with its own label and metadata. Hierarchical Data Format version 5 (HDF5) is an open-source binary file format designed to store and organize extremely large, complex scientific datasets using a filesystem-like structure of groups and datasets.

## Why it matters
Machine learning pipelines and AI security tools increasingly use HDF5 to store trained model weights (e.g., Keras `.h5` files). An attacker who compromises a shared model repository can embed malicious serialized objects within HDF5 files — when the victim loads the model with `h5py` or TensorFlow, arbitrary code executes, making HDF5 a vector for supply chain attacks against ML infrastructure. Defenders must validate file integrity via cryptographic hashes and restrict model loading to trusted, signed sources.

## Key facts
- HDF5 files use the `.h5` or `.hdf5` extension and are the default save format for Keras/TensorFlow neural network models
- The format supports arbitrary metadata attributes alongside datasets, meaning malicious payloads can hide in attribute fields without obvious detection
- Deserialization vulnerabilities in `h5py` and related libraries have enabled remote code execution — treat HDF5 files from untrusted sources like executable code
- HDF5 is platform-independent and self-describing, meaning the file carries its own schema, which also means parsers must handle complex, attacker-controlled structures
- CVE-2018-17435 and related CVEs document heap buffer overflows in the HDF5 reference library triggered by crafted files — patch library versions aggressively

## Related concepts
[[Deserialization Attacks]] [[Supply Chain Security]] [[Machine Learning Security]] [[File Format Vulnerabilities]]