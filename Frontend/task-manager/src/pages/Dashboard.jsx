import { useState, useEffect } from "react"
import { useNavigate } from "react-router-dom"
import TaskModal from "../components/TaskModal"
import TaskList from "../components/TaskList"
import { getTasks, createTask, updateTaskStatus, deleteTask } from "../api"

function Dashboard() {
    const navigate = useNavigate()
    const [tasks, setTasks] = useState([])
    const [isModalOpen, setIsModalOpen] = useState(false)

    useEffect(() => {
        fetchTasks()
    }, [])

    const fetchTasks = async () => {
        try {
            const data = await getTasks()
            setTasks(data)
        } catch (error) {
            console.error("Failed to fetch tasks", error)
        }
    }

    const handleAddTask = async (taskData) => {
        try {
            const newTask = await createTask({ ...taskData, done: false })
            setTasks([...tasks, newTask])
        } catch (error) {
            console.error("Failed to add task", error)
        }
    }

    const handleDelete = async (id) => {
        try {
            await deleteTask(id)
            setTasks(tasks.filter((t) => t.id !== id))
        } catch (error) {
            console.error("Failed to delete task", error)
        }
    }

    const handleToggle = async (id) => {
        try {
            const taskToToggle = tasks.find(t => t.id === id)
            if (!taskToToggle) return
            const updatedTask = await updateTaskStatus(id, !taskToToggle.done)
            setTasks(tasks.map((t) => (t.id === id ? updatedTask : t)))
        } catch (error) {
            console.error("Failed to update task", error)
        }
    }

    const done = tasks.filter((t) => t.done).length
    const total = tasks.length

    return (
        <div className="min-h-screen bg-gradient-to-br from-indigo-50 via-white to-purple-50">

            {/* Top Nav */}
            <header className="bg-white border-b border-gray-100 shadow-sm px-8 py-4 flex items-center justify-between">
                <div className="flex items-center gap-3">
                    <div className="bg-indigo-600 text-white w-9 h-9 rounded-xl flex items-center justify-center">
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
                        </svg>
                    </div>
                    <span className="text-lg font-bold text-gray-800">TaskManager</span>
                </div>
                <button
                    onClick={() => navigate("/")}
                    className="text-sm text-gray-500 hover:text-red-500 font-medium transition flex items-center gap-1"
                >
                    <svg className="w-4 h-4" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                    </svg>
                    Logout
                </button>
            </header>

            {/* Main Content */}
            <main className="max-w-2xl mx-auto px-4 py-12">

                {/* Header & Add Button */}
                <div className="mb-8 flex items-end justify-between">
                    <div>
                        <h1 className="text-3xl font-bold text-gray-800 mb-1">My Tasks</h1>
                        <p className="text-gray-400 text-sm">
                            {done} of {total} tasks completed
                        </p>
                        {/* Progress Bar */}
                        <div className="mt-3 h-2 w-48 bg-gray-100 rounded-full overflow-hidden">
                            <div
                                className="h-full bg-indigo-500 rounded-full transition-all duration-500"
                                style={{ width: total > 0 ? `${(done / total) * 100}%` : "0%" }}
                            />
                        </div>
                    </div>

                    <button
                        onClick={() => setIsModalOpen(true)}
                        className="bg-indigo-600 hover:bg-indigo-700 text-white px-5 py-2.5 rounded-xl font-semibold shadow-md hover:shadow-lg transition-all flex items-center gap-2"
                    >
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M12 4v16m8-8H4" />
                        </svg>
                        Add Task
                    </button>
                </div>

                {/* Stats Row */}
                <div className="grid grid-cols-3 gap-4 mb-6">
                    <div className="bg-white rounded-xl p-4 shadow-sm border border-gray-100 text-center">
                        <p className="text-2xl font-bold text-indigo-600">{total}</p>
                        <p className="text-xs text-gray-400 mt-1">Total</p>
                    </div>
                    <div className="bg-white rounded-xl p-4 shadow-sm border border-gray-100 text-center">
                        <p className="text-2xl font-bold text-green-500">{done}</p>
                        <p className="text-xs text-gray-400 mt-1">Done</p>
                    </div>
                    <div className="bg-white rounded-xl p-4 shadow-sm border border-gray-100 text-center">
                        <p className="text-2xl font-bold text-yellow-500">{total - done}</p>
                        <p className="text-xs text-gray-400 mt-1">Pending</p>
                    </div>
                </div>

                {/* Task List */}
                <div className="bg-white rounded-2xl shadow-sm border border-gray-100 p-6">
                    <h2 className="text-base font-semibold text-gray-700 mb-5">All Tasks</h2>
                    <TaskList tasks={tasks} onDelete={handleDelete} onToggle={handleToggle} />
                </div>

                {/* Modal */}
                <TaskModal
                    isOpen={isModalOpen}
                    onClose={() => setIsModalOpen(false)}
                    onAddTask={handleAddTask}
                />
            </main>
        </div>
    )
}

export default Dashboard