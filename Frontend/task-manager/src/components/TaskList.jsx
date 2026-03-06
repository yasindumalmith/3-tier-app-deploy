import { useState } from "react"

function TaskList({ tasks, onDelete, onToggle }) {
    if (tasks.length === 0) {
        return (
            <div className="text-center py-16 text-gray-400">
                <svg className="w-12 h-12 mx-auto mb-3 opacity-40" fill="none" stroke="currentColor" strokeWidth="1.5" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                </svg>
                <p className="text-sm font-medium">No tasks yet. Add one above!</p>
            </div>
        )
    }

    return (
        <ul className="space-y-3">
            {tasks.map((task) => (
                <li
                    key={task.id}
                    className="flex items-center gap-4 bg-white border border-gray-100 rounded-xl px-5 py-4 shadow-sm hover:shadow-md transition group"
                >
                    {/* Checkbox */}
                    <button
                        onClick={() => onToggle(task.id)}
                        className={`w-6 h-6 rounded-full border-2 flex items-center justify-center flex-shrink-0 transition-all ${task.done
                            ? "bg-green-500 border-green-500 text-white"
                            : "border-gray-300 hover:border-indigo-400"
                            }`}
                    >
                        {task.done && (
                            <svg className="w-3 h-3" fill="none" stroke="currentColor" strokeWidth="3" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                            </svg>
                        )}
                    </button>

                    {/* Content */}
                    <div className={`flex-1 transition-all ${task.done ? "opacity-50" : ""}`}>
                        <div className={`text-sm font-medium ${task.done ? "line-through text-gray-400" : "text-gray-700"}`}>
                            {task.title}
                        </div>
                        {task.description && (
                            <div className="text-xs text-gray-500 mt-1 line-clamp-2">
                                {task.description}
                            </div>
                        )}
                    </div>

                    {/* Delete */}
                    <button
                        onClick={() => onDelete(task.id)}
                        className="text-gray-300 hover:text-red-500 transition opacity-0 group-hover:opacity-100"
                    >
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                        </svg>
                    </button>
                </li>
            ))}
        </ul>
    )
}

export default TaskList