// prettier-ignore
{{flutter_js}}
// prettier-ignore
{{flutter_build_config}}

let app;

const loadApp = (appUrl) => {
  _flutter.loader.load({
    config: {
      entryPointBaseUrl: appUrl,
      canvasKitBaseUrl: `${appUrl}/canvaskit/`,
    },
    onEntrypointLoaded: async (engineInitializer) => {
      const engine = await engineInitializer.initializeEngine({
        assetBase: appUrl,
        multiViewEnabled: true,
      });
      app = await engine.runApp();
    },
  });
};

const loadView = (hostElement, category) => {
  const viewId = app.addView({
    hostElement: hostElement,
    initialData: {
      category: category,
    },
  });
  return viewId;
};

const unloadView = (viewId) => {
  app.removeView(viewId);
};
