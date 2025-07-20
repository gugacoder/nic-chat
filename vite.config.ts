import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig, loadEnv } from 'vite';

import { viteStaticCopy } from 'vite-plugin-static-copy';

export default defineConfig(({ mode }) => {
	const env = loadEnv(mode, process.cwd(), '');
	
	return {
		plugins: [
			sveltekit(),
			viteStaticCopy({
				targets: [
					{
						src: 'node_modules/onnxruntime-web/dist/*.jsep.*',
						dest: 'wasm'
					}
				]
			})
		],
		server: {
			port: 3000,
			allowedHosts: env.VITE_ALLOWED_HOSTS?.split(',') || []
		},
		define: {
			APP_VERSION: JSON.stringify(process.env.npm_package_version),
			APP_BUILD_HASH: JSON.stringify(process.env.APP_BUILD_HASH || 'dev-build')
		},
		build: {
			sourcemap: true
		},
		worker: {
			format: 'es'
		},
		esbuild: {
			pure: process.env.ENV === 'dev' ? [] : ['console.log', 'console.debug']
		}
	};
});