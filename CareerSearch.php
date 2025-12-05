<?php
// Database configuration
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'advisor');

// Initialize variables
$searchTerm = '';
$results = [];
$errorMessage = '';
$showResults = false;

// Process search if form submitted
if (isset($_GET['search']) && !empty(trim($_GET['search']))) {
    $searchTerm = trim($_GET['search']);
    $showResults = true;
    
    try {
        // Create database connection
        $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
        
        // Check connection
        if ($conn->connect_error) {
            throw new Exception("Connection failed: " . $conn->connect_error);
        }
        
        // Prepare search query - searches Jobs and Majors, then joins to get all related info
        $searchParam = "%{$searchTerm}%";
        $stmt = $conn->prepare("
            SELECT DISTINCT
                j.JobID,
                j.Job_name, 
                j.Final_degree, 
                j.years_needed, 
                j.avgCost, 
                j.Salary,
                GROUP_CONCAT(DISTINCT m.Major_name ORDER BY m.Major_name SEPARATOR ', ') as majors
            FROM Jobs j
            LEFT JOIN Major_Jobs mj ON j.JobID = mj.JobID
            LEFT JOIN Major m ON mj.MajorID = m.MajorID
            WHERE j.Job_name LIKE ? 
               OR j.Final_degree LIKE ?
               OR m.Major_name LIKE ?
            GROUP BY j.JobID, j.Job_name, j.Final_degree, j.years_needed, j.avgCost, j.Salary
            ORDER BY j.Job_name ASC
        ");
        
        $stmt->bind_param("sss", $searchParam, $searchParam, $searchParam);
        $stmt->execute();
        $result = $stmt->get_result();
        
        // Fetch all results
        while ($row = $result->fetch_assoc()) {
            $results[] = $row;
        }
        
        // Check if no results found
        if (empty($results)) {
            $errorMessage = 'No results found. Try searching for careers like "Doctor", "Nurse", or majors like "Biology", "Chemistry".';
        }
        
        $stmt->close();
        $conn->close();
        
    } catch (Exception $e) {
        $errorMessage = 'Error connecting to database. Please try again later.';
        error_log('Database error: ' . $e->getMessage());
    }
}

// Helper function to escape HTML
function escapeHtml($text) {
    return htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
}

// Helper function to format majors display
function formatMajors($majorsString) {
    // If no majors linked in database, return "No specific major required"
    if (empty($majorsString) || trim($majorsString) === '') {
        return 'No specific major required';
    }
    
    $majorsArray = array_map('trim', explode(',', $majorsString));
    $limitedMajors = array_slice($majorsArray, 0, 3);
    $display = implode(', ', $limitedMajors);
    
    // Add indicator if there are more majors
    if (count($majorsArray) > 3) {
        $remaining = count($majorsArray) - 3;
        $display .= ' <span style="color: var(--gold-75); font-weight: 600;">(+' . $remaining . ' more)</span>';
    }
    
    return $display;
}

// Helper function to format currency
function formatCurrency($value) {
    if (empty($value) || $value <= 0) {
        return 'N/A';
    }
    return '$' . number_format($value, 0);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LU Med Pathfinder: Find Your Major</title>
    <link rel="stylesheet" href="CSS/style1.css">
</head>
<body class="font">
    <header>
        <nav>
            <a href="index.html">
                <img class="nav-logo" src="Images/LU-logo-standard.png" alt="Lindenwood University Logo">
            </a>
            <div class="fontBOLD">DISCOVER YOUR ROAR. FIND YOUR CAREER PATH OR MAJOR.</div>
        </nav>
    </header>
    <main class="content">
        <form method="GET" action="CareerSearch.php" class="search-form">
            <div class="search-container">
                <input 
                    type="text" 
                    id="career-search" 
                    name="search" 
                    placeholder="Search for a career or major..." 
                    value="<?php echo escapeHtml($searchTerm); ?>"
                    autofocus
                    required>
                <button type="submit" class="search-button">🔍</button>
            </div>
        </form>

        <?php if ($showResults): ?>
            <?php if (!empty($errorMessage)): ?>
                <div id="error-message" style="color:red; text-align:center; padding:20px;">
                    <?php echo escapeHtml($errorMessage); ?>
                </div>
            <?php endif; ?>

            <?php if (!empty($results)): ?>
                <div class="cards-container" id="results-container">
                    <?php 
                    // Group results by career to create separate cards for each major
                    $expandedResults = [];
                    foreach ($results as $career) {
                        if (!empty($career['majors'])) {
                            $majorsArray = array_map('trim', explode(',', $career['majors']));
                            foreach ($majorsArray as $major) {
                                $expandedResults[] = [
                                    'Job_name' => $career['Job_name'],
                                    'major' => $major,
                                    'Final_degree' => $career['Final_degree'],
                                    'years_needed' => $career['years_needed'],
                                    'avgCost' => $career['avgCost'],
                                    'Salary' => $career['Salary']
                                ];
                            }
                        } else {
                            // Career with no specific major
                            $expandedResults[] = [
                                'Job_name' => $career['Job_name'],
                                'major' => null,
                                'Final_degree' => $career['Final_degree'],
                                'years_needed' => $career['years_needed'],
                                'avgCost' => $career['avgCost'],
                                'Salary' => $career['Salary']
                            ];
                        }
                    }
                    
                    // Limit to exactly 3 cards
                    $expandedResults = array_slice($expandedResults, 0, 3);
                    
                    foreach ($expandedResults as $index => $item): 
                    ?>
                        <div class="card fontBOLD" style="animation-delay: <?php echo ($index * 0.05); ?>s;">
                            <h3><?php echo escapeHtml($item['Job_name']); ?></h3>
                            <p><strong>Recommended Major:</strong> <?php echo $item['major'] ? escapeHtml($item['major']) : 'No specific major required'; ?></p>
                            <div class="separator"></div>
                            <p><strong>Final Degree:</strong> <?php echo escapeHtml($item['Final_degree'] ?: 'N/A'); ?></p>
                            <p><strong>Total Years of Education:</strong> <?php echo intval($item['years_needed'] ?: 4); ?> years</p>
                            <p><strong>Estimated Cost:</strong> <?php echo formatCurrency($item['avgCost']); ?></p>
                            <div class="separator"></div>
                            <p><strong>Average Salary:</strong> <?php echo formatCurrency($item['Salary']); ?></p>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <button class="button fontBOLD" onclick="window.location.href='CareerSearch.php'" id="search-again-btn">
                SEARCH AGAIN
            </button>
        <?php endif; ?>
    </main>
</body>
</html>