# Multi-stage build

FROM python:3.11
WORKDIR /app

# Install backend dependencies
COPY backend/pyproject.toml backend/uv.lock ./backend/
RUN pip install uv && cd backend && uv sync

# Copy backend code
COPY backend/ ./backend/

FROM node:18 as frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# Copy built frontend
COPY --from=frontend-build /app/frontend/dist ./frontend/dist

# Serve both frontend and backend
EXPOSE 8000
CMD ["python", "backend/app/main.py"]