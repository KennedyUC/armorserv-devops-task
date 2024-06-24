exports.handler = async (event) => {
    try {
        const name = event && event.queryStringParameters && event.queryStringParameters.name ? event.queryStringParameters.name : 'Lambda';

        const response = {
            statusCode: 200,
            headers: {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            body: JSON.stringify({ message: `Hello ${name} from Lambda!` }),
        };

        return response;
    } catch (err) {
        console.error('Error:', err.message);

        return {
            statusCode: 500,
            headers: {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },
            body: JSON.stringify({ message: 'Internal server error' })
        };
    }
};