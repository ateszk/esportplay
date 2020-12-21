<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\Sponsor;

class SponsorDBAL
{
    use DBALTrait;

    public function updateSponsorOrder()
    {
        $request = $this->request;
        if (!empty($sortedIds = $request->get('sortedIds'))) {

            $response = '';
            $i=0;
            foreach ($sortedIds as $sponsorId) {
                $sponsorId = (int)$sponsorId;
                $response = Sponsor::query()
                    ->update(['order_number' => $i])
                    ->where('id', $sponsorId)
                    ->exec()
                ;

                $i++;
            }

            return $response;
        }

        return [];
    }

    public function createSponsor()
    {
        $request = $this->request;
        $socialArray = [];
        $sponsorData = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, ['facebook', 'instagram', 'twitter', 'twitch', 'steam'])) {
                $socialArray[$key] = $value;
                continue;
            }

            $sponsorData[$key] = $value;
        }

        global $wpdb;
        $query = 'SELECT MAX(order_number) as `number` FROM '.$wpdb->prefix.'pixiefreak_sponsor GROUP BY id ORDER BY number DESC LIMIT 1';
        $sponsorData['order_number'] = 0;
        if (!empty($result = Sponsor::query()->raw($query, [])->first())) {
            $sponsorData['order_number'] = $sponsorData['order_number'] + $result->number;
        }

        $sponsorData['social'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        return Sponsor::query()->insert($sponsorData);
    }

    public function removeSponsor()
    {
        $request = $this->request;
        return Sponsor::query()->delete($request->get('sponsorId'));
    }

    public function updateSponsor()
    {
        $request = $this->request;
        $socialArray = [];
        $sponsorData  = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, ['facebook', 'instagram', 'twitter', 'twitch', 'steam'])) {
                $socialArray[$key] = $value;
                continue;
            }

            $sponsorData[$key] = $value;
        }

        $sponsorData['social'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        return Sponsor::query()
            ->update($sponsorData)
            ->where($request->get('sponsorId'))
            ->exec()
        ;
    }
}