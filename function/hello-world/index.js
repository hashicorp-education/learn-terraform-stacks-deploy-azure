module.exports = async function (context, req) {
	const name = req.query.name || (req.body && req.body.name) || "World";

	context.res = {
		status: 200,
		headers: {
			"Content-Type": "text/plain"
		},
		body: `Hello, ${name}!`
	};
};
