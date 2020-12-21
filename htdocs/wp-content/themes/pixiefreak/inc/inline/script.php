<script>
(function($){

    let bracketData = <?php echo \PixieFreakPanel\Model\Tournament::query()->brackets($tournament); ?>;

    $('.panzoom-elements').bracket({
        init: bracketData, /* data to initialize the bracket with */
        teamWidth: 200,
        scoreWidth: 48,
        matchMargin: 50,
        roundMargin: 70,
        skipConsolationRound: true,
        centerConnectors: true,
        decorator: {
            edit: function acEditFn(container, data, doneCb) {
                return false
            },
            render: function render_fn(container, data, score, state) {
                switch (state) {
                    case "empty-bye":
                        container.append("No team")
                        return;
                    case "empty-tbd":
                        container.append("Upcoming")
                        return;
                    case "entry-no-score":
                    case "entry-default-win":
                    case "entry-complete":
                        container.append('<img src="' + data.teamlogo + '" alt="Team logo"> ').append(data.name)
                        return;
                }
            }
        }
    });

    // PanZoom
    $(".panzoom-elements").panzoom({
        minScale: 0,
        $zoomIn: $(".brackets").find(".zoomIn"),
        $zoomOut: $(".brackets").find(".zoomOut"),
    });
})(jQuery);
</script>