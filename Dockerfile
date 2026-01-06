FROM swift:5.7

# Install GD dependencies
RUN apt-get update && apt-get install -y \
    libgd-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /data

# Create app directory
WORKDIR /code

# Copy the Swift package into the container
# COPY . .

# # Build the app
# RUN swift build

# # Run the app
# CMD ["swift", "run"]
