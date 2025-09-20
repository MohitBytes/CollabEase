#!/bin/bash

# CollabEase Build and Deploy Script

echo "🚀 Building CollabEase..."

# Build the WAR file
echo "📦 Building WAR file..."
mvn clean package -DskipTests

if [ ! -f target/CollabEase.war ]; then
    echo "❌ WAR file build failed!"
    exit 1
fi

echo "✅ WAR file built successfully!"

# Build Docker image
echo "🐳 Building Docker image..."
docker build -t collabease .

if [ $? -eq 0 ]; then
    echo "✅ Docker image built successfully!"
else
    echo "❌ Docker image build failed!"
    exit 1
fi

echo "🎉 Build completed! You can now run:"
echo "   docker compose up -d"
echo ""
echo "📖 Or follow the deployment guide in DEPLOYMENT.md"