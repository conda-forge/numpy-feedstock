local Pipeline(name, image, platform) = {
  kind: "pipeline",
  name: name,
  platform: {
    os: linux
    arch: arm64
  }
  steps: [
    {
      name: "Build using docker",
      image: image,
      environment: {
         CONFIG: name
         UPLOAD_PACKAGES: True
         PLATFORM: platform
      }
      commands: [
        'export FEEDSTOCK_ROOT="$CI_WORKSPACE"',
        'export RECIPE_ROOT="$FEEDSTOCK_ROOT/recipe"',
        'export CI=drone',
        '. /opt/conda/bin/activate',
        './.drone/build_steps.sh',
      ]
    }
  ]
};

[
  Pipeline("linux_aarch64_python2.7", "condaforge/linux-anvil-aarch64", "linux-aarch64"),
  Pipeline("linux_aarch64_python3.6", "condaforge/linux-anvil-aarch64", "linux-aarch64"),
  Pipeline("linux_aarch64_python3.7", "condaforge/linux-anvil-aarch64", "linux-aarch64"),
]
