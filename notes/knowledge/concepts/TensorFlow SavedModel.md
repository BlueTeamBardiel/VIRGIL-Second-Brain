# TensorFlow SavedModel

## What it is
Like a frozen recipe card that contains both the ingredients list AND the cooking equipment baked in, a TensorFlow SavedModel packages a trained ML model's architecture, weights, and computation graph into a single portable directory. It is TensorFlow's standard serialization format, storing everything needed to reload and execute a model without requiring the original training code.

## Why it matters
Attackers can craft malicious SavedModel files that execute arbitrary code when loaded via `tf.saved_model.load()`, exploiting the format's ability to embed custom Python objects and Lambda layers — effectively turning model sharing into a supply chain attack vector. A compromised ML model repository (like a public Hugging Face endpoint) distributing poisoned SavedModels could give attackers code execution on any data scientist's machine that loads the file, bypassing traditional AV scanning since the payload lives inside a serialized neural network.

## Key facts
- SavedModels store data in a directory containing `saved_model.pb` (the computation graph) and a `variables/` subdirectory — the `.pb` file alone is not the complete model
- The format supports embedded `tf.function` traces which can call `tf.py_function`, enabling arbitrary Python execution at load time
- Deserialization attacks against SavedModels are analogous to Python `pickle` attacks — untrusted model files should never be loaded in privileged environments
- TensorFlow's `tf.keras.models.load_model()` wraps SavedModel loading and is equally vulnerable to malicious architectures containing custom `Lambda` layers
- Defense-in-depth controls include sandboxing model loading in isolated containers, cryptographic signing of model artifacts, and using model cards with provenance attestation

## Related concepts
[[Supply Chain Attack]] [[Deserialization Vulnerabilities]] [[Model Poisoning]] [[Arbitrary Code Execution]] [[Software Composition Analysis]]