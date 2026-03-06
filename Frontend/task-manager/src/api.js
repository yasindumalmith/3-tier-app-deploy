import axios from "axios";

// Create an Axios instance with a base URL
// Change this URL to match your backend when it's ready
const API_BASE_URL = "http://localhost:8081/api";

const api = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        "Content-Type": "application/json",
    },
});

// --- Auth Endpoints ---
export const login = async (credentials) => {
    const response = await api.post("/auth/login", credentials);
    return response.data;
};

export const signup = async (credentials) => {
    const response = await api.post("/auth/signup", credentials);
    return response.data;
};

// --- Task Endpoints ---
export const getTasks = async () => {
    const response = await api.get("/tasks");
    return response.data;
};

export const createTask = async (taskData) => {
    const response = await api.post("/tasks", taskData);
    return response.data;
};

export const updateTaskStatus = async (id, done) => {
    const response = await api.patch(`/tasks/${id}`, { done });
    return response.data;
};

export const deleteTask = async (id) => {
    const response = await api.delete(`/tasks/${id}`);
    return response.data;
};

export default api;
