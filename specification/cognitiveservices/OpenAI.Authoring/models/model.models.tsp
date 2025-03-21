import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;

namespace Azure.OpenAI;

@doc("A model is either a base model or the result of a successful fine tune job.")
@resource("models")
model Model {
  @doc("Defines the type of an object.")
  @visibility("read")
  object?: TypeDiscriminator;

  @doc("The state of a job or item.")
  @visibility("read")
  status?: State;

  @doc("A timestamp when this job or item was created (in unix epochs).")
  @visibility("read")
  created_at?: int32;

  @doc("A timestamp when this job or item was modified last (in unix epochs).")
  @visibility("read")
  updated_at?: int32;

  @doc("The identity of this item.")
  @visibility("read")
  @key("model_id")
  id: string;

  @doc("The base model ID if this is a fine tune model; otherwise `null`.")
  @visibility("read")
  "model"?: string;

  @doc("The fine tune job ID if this is a fine tune model; otherwise `null`.")
  @visibility("read")
  fine_tune?: string;

  @doc("The capabilities of a base or fine tune model.")
  capabilities?: Capabilities;

  @doc("""
Defines the dates of deprecation for the different use cases of a
model.
Usually base models support 1 year of fine tuning after creation.
Inference is typically supported 2 years after creation of base or
fine tuned
models. The exact dates are specified in the properties.
""")
  deprecation?: Deprecation;
}

@doc("The capabilities of a base or fine tune model.")
model Capabilities {
  @doc("A value indicating whether a model can be used for fine tuning.")
  @visibility("read")
  fine_tune?: boolean;

  @doc("A value indicating whether a model can be deployed.")
  @visibility("read")
  inference?: boolean;

  @doc("A value indicating whether a model supports completion.")
  @visibility("read")
  completion?: boolean;

  @doc("A value indicating whether a model supports embeddings.")
  @visibility("read")
  embeddings?: boolean;

  @doc("The supported scale types for deployments of this model.")
  @visibility("read")
  scale_types?: ScaleType[];
}

@doc("""
Defines the dates of deprecation for the different use cases of a
model.
Usually base models support 1 year of fine tuning after creation.
Inference is typically supported 2 years after creation of base or
fine tuned
models. The exact dates are specified in the properties.
""")
model Deprecation {
  @doc("""
The end date of fine tune support of this model. Will be `null` for fine tune
models.
""")
  @visibility("read")
  fine_tune_end_date?: int32;

  @doc("The end date of inference support of this model.")
  @visibility("read")
  inference?: int32;
}

@doc("Settings for the manual scale type.")
model ManualScaleSettings extends ScaleSettings {
  @doc("The constant reserved capacity of the inference endpoint for this deployment.")
  capacity: int32;

  @doc("Defines how scaling operations will be executed.")
  scale_type: "manual";
}

@doc("Settings for the standard scale type.")
model StandardScaleSettings extends ScaleSettings {
  @doc("Defines how scaling operations will be executed.")
  scale_type: "standard";
}
