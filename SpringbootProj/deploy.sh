#!/bin/bash

set -e

NAMESPACE="my-app-ns"

echo "🔍 Validating manifests..."
kubectl apply -f k8s/ --dry-run=client -o yaml

echo "🚀 Creating namespace (if needed)..."
kubectl apply -f k8s/namespace.yml

echo "📦 Applying resources..."
kubectl apply -f k8s/

echo "✅ Done!"
kubectl get all -n $NAMESPACE
