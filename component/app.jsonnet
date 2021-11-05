local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.blackbox_exporter;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('blackbox-exporter', params.namespace);

{
  'blackbox-exporter': app,
}
