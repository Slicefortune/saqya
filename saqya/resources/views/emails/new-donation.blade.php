<!DOCTYPE html>
<html>
<head>
    <title>New Donation Notification</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f0f0f0;
        }

        h1 {
            color: #333;
        }

        p {
            color: #666;
        }
    </style>
</head>
<body>

<div class="container">

    <h1>New Donation Received!</h1>

    <p>A new donation has been made.</p>

    <ul>
        <li>**Amount:** {{ $mailData['amount'] }} BHD</li>
        <li>** Donation Date:** {{ $mailData['donation_date']->format('F j, Y') }}</li>
    </ul>

</div>

</body>
</html>