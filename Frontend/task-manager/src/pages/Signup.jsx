import { useState } from "react"
import { useNavigate } from "react-router-dom"
import { signup } from "../api"

function Signup() {
    const navigate = useNavigate()
    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")
    const [confirmPassword, setConfirmPassword] = useState("")
    const [error, setError] = useState("")
    const [success, setSuccess] = useState(false)

    const handleSignup = async (e) => {
        e.preventDefault()
        setError("")
        setSuccess(false)

        if (password !== confirmPassword) {
            setError("Passwords do not match")
            return
        }

        try {
            await signup({ email, password })
            setSuccess(true)
            setTimeout(() => navigate("/"), 2000)
        } catch (err) {
            if (err.response && err.response.status === 409) {
                setError("Email already exists")
            } else {
                setError("Failed to create account. Please try again.")
            }
        }
    }

    return (
        <div className="min-h-screen bg-gradient-to-br from-indigo-100 via-purple-50 to-blue-100 flex items-center justify-center px-4">
            <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-10">

                <div className="flex justify-center mb-6">
                    <div className="bg-indigo-600 text-white w-14 h-14 rounded-2xl flex items-center justify-center shadow-lg">
                        <svg className="w-7 h-7" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                        </svg>
                    </div>
                </div>

                <h2 className="text-3xl font-bold text-center text-gray-800 mb-1">Create an account</h2>
                <p className="text-center text-gray-400 text-sm mb-8">Join Task Manager today</p>

                {error && <p className="text-red-500 text-sm text-center mb-4">{error}</p>}
                {success && <p className="text-green-500 text-sm text-center mb-4">Account created successfully! Redirecting...</p>}

                <form onSubmit={handleSignup} className="space-y-4">
                    <div>
                        <label className="block text-sm font-medium text-gray-600 mb-1">Email</label>
                        <input
                            type="email"
                            required
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
                            required
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            placeholder="••••••••"
                            className="w-full px-4 py-3 rounded-lg border border-gray-200 bg-gray-50 text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent transition"
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-medium text-gray-600 mb-1">Confirm Password</label>
                        <input
                            type="password"
                            required
                            value={confirmPassword}
                            onChange={(e) => setConfirmPassword(e.target.value)}
                            placeholder="••••••••"
                            className="w-full px-4 py-3 rounded-lg border border-gray-200 bg-gray-50 text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-indigo-400 focus:border-transparent transition"
                        />
                    </div>

                    <button
                        type="submit"
                        disabled={success}
                        className={`w-full py-3 rounded-lg font-semibold text-sm tracking-wide transition-all shadow-md mt-4 ${success ? 'bg-green-500 text-white cursor-not-allowed' : 'bg-indigo-600 hover:bg-indigo-700 text-white hover:shadow-lg'}`}
                    >
                        {success ? 'Success!' : 'Create Account'}
                    </button>
                </form>

                <p className="text-center text-sm text-gray-400 mt-8">
                    Already have an account?{" "}
                    <button onClick={() => navigate("/")} className="text-indigo-600 font-medium hover:underline">Sign in</button>
                </p>
            </div>
        </div>
    )
}

export default Signup
