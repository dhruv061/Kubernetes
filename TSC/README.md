# Configure Topology Spread Constraints in Deployment

### This helps us to schedule our deployment pods eqully in all availble node.

### Implmentation flow
1. **Apply a label to all nodes** where you want to deploy your pod equally.

2. **Add a `nodeAffinity` rule** in the pod specification to target the nodes using the label applied in step 1.

3. **Add `topologySpreadConstraints`** to ensure your pods are distributed equally across the selected nodes.


### 1 - Apply Label to all node in which we have to schdule our pod

```sh
kubectl label <node-name> <key>>=<value>
```
kubectl label nodes ip-172-31-22-202.ap-south-1.compute.internal node-type=spot

### 2 - Apply nodeAffinity

```yaml
affinity:
nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
    nodeSelectorTerms:
        - matchExpressions:
            - key: node-type
            operator: In
            values:
                - spot
                - on-demand
```

- In this nodeAffinity we says select nodes that have label "spot" and "on-demand". so our pod is only shcdule inn this node.

### 3 - Apply topologySpreadConstraints

```yaml
topologySpreadConstraints:
- maxSkew: 1
    topologyKey: kubernetes.io/hostname
    # whenUnsatisfiable: DoNotSchedule
    whenUnsatisfiable: ScheduleAnyway
    labelSelector:
    matchLabels:
        app: apache
```

#### maxSkew: how many pod is schdule in every node. (in this case 1 pod schdule to each node).
####  topologyKey: way to select node. In this case we use "kubernetes.io/hostname" menas select all node for pod schduling but we filter it out using label in above nodeaffinity to select particlur node.
####  whenUnsatisfiable: what happen when our condition is not satsify (DoNotSchedule OR ScheduleAnyway)
####  labelSelector: select pod using label