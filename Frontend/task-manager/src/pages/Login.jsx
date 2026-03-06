import { useState } from "react"
import { useNavigate } from "react-router-dom"
import { login } from "../api"

function Login() {
    const navigate = useNavigate()
    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")
    const [error, setError] = useState("")

    const handleLogin = async (e) => {
        e.preventDefault()
        try {
            await login({ email, password })
            navigate("/dashboard")
        } catch (err) {
            setError("Invalid credentials")
        }
    }

    return (
        <div className="min-h-screen bg-gradient-to-br from-indigo-100 via-purple-50 to-blue-100 flex items-center justify-center px-4">
            <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-10">

                {/* Logo / Icon */}
                <div className="flex justify-center mb-6">
                    <div className="bg-indigo-600 text-white w-14 h-14 rounded-2xl flex items-center justify-center shadow-lg">
                        <svg className="w-7 h-7" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
                        </svg>
                    </div>
                </div>

                <h2 className="text-3xl font-bold text-center text-gray-800 mb-1">Welcome back</h2>
                <p className="text-center text-gray-400 text-sm mb-8">Sign in to your Task Manager</p>

                {error && <p className="text-red-500 text-sm text-center mb-4">{error}</p>}

                <form onSubmit={handleLogin} className="space-y-5">
                    <div>
                        <label className="block text-sm font-medium text-gray-600 mb-1">Email</label>
                        <input
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            placeholder="you@example.com"
                            className="w-full px-4 py-3 rounded-lg border border-gray-200 bg-gray-50 text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent transition"
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-600 mb-1">Password</label>
                        <input
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            placeholder="••••••••"
                            className="w-full px-4 py-3 rounded-lg border border-gray-200 bg-gray-50 text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent transition"
                        />
                    </div>

                    <div className="flex items-center justify-between text-sm">
                        <label className="flex items-center gap-2 text-gray-500 cursor-pointer">
                            <input type="checkbox" className="accent-indigo-600" />
                            Remember me
                        </label>
                        <a href="#" className="text-indigo-600 hover:underline font-medium">Forgot password?</a>
                    </div>

                    <button
                        type="submit"
                        className="w-full bg-indigo-600 hover:bg-indigo-700 text-white py-3 rounded-lg font-semibold text-sm tracking-wide transition-all shadow-md hover:shadow-lg"
                    >
                        Sign In
                    </button>
                </form>

                <p className="text-center text-sm text-gray-400 mt-8">
                    Don't have an account?{" "}
                    <button onClick={() => navigate("/signup")} className="text-indigo-600 font-medium hover:underline">Sign up</button>
                </p>
            </div>
        </div>
    )
}

export default Login