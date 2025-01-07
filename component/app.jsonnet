local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.blackbox_exporter;
local argocd = import 'lib/argocd.libjsonnet';
local instance = inv.parameters._instance;

local app = argocd.App(instance, params.namespace) {
  spec+: {
    ignoreDifferences: [
      {
        group: 'monitoring.coreos.com',
        kind: 'ServiceMonitor',
        jqPathExpressions: [
          '.spec.endpoints[].metricRelabelings[]',
        ],
      },
    ],
  },
};

local appPath =
  local project = std.get(app, 'spec', { project: 'syn' }).project;
  if project == 'syn' then 'apps' else 'apps-%s' % project;

{
  ['%s/%s' % [ appPath, instance ]]: app,
}
