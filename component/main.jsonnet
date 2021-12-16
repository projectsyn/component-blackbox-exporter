// main template for blackbox-exporter
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.blackbox_exporter;
local instance = inv.parameters._instance;

// Define outputs below
{
  [if params.createNamespace then params.namespace]: kube.Namespace(params.namespace),
}
