<app>
	<translation show="{ token }"></translation>
	<script>
		const speech = new webkitSpeechRecognition();

		speech.lang = 'ko';

		speech() {
			speech.start();
		}

		this.token = false;
		this.on("mount", () => {
			const { google } = this.opts;
			const { translation } = this.tags;

			google
				.token()
				.then(() => {
					this.token = true;
					this.update();
				}).then(() => {
					speech.addEventListener('result', (event) => {
						const source = event.results[0][0].transcript;

						translation.opts.source = source;
						this.update();

						google.translate(source).then(target => {
							translation.opts.target = target;
							this.update();
						});
					});
				});
		});
	</script>
</app>
