self: super: {
  nodejs = super.nodejs.override {
    version = "24.0.1";
  };

  nodejs-slim = super.nodejs-slim.override {
    version = "24.0.1";
  };
}
