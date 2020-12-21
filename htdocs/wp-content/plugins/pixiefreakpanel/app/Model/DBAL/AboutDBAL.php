<?php

namespace PixieFreakPanel\Model\DBAL;

use PixieFreakPanel\Model\About;
use PixieFreakPanel\Model\AboutStaff;
use PixieFreakPanel\Model\AboutStaffCategory;

class AboutDBAL
{
    use DBALTrait;

    /**
     * @return mixed
     */
    public function statistic()
    {
        $request = $this->request;
        $statisticArray = array_chunk($request->get('values'), 3);
        foreach (array_chunk($request->get('values'), 3) as $key => $value) {
            $statisticArray[$key] = array_combine(['icon', 'title', 'label'], $value);
        }

        $aboutQuery = About::query();
        $aboutId = $aboutQuery->get()->first()->id;
        $statisticJson = json_encode($statisticArray, JSON_UNESCAPED_SLASHES);
        return About::query()
            ->update(['stats' => $statisticJson])
            ->where('id', (int) $aboutId)
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function updateImages()
    {
        $request = $this->request;
        $aboutQuery = About::query();
        foreach (['cover','banner'] as $key) {
        	if (empty($request->get($key))) {
        		continue;
	        }

	        return About::query()
                    ->update([$key => $request->get($key)])
                    ->where('id', (int) $aboutQuery->get()->first()->id)
                    ->exec()
	        ;
        }

        return true;
    }

    /**
     * @return mixed
     */
    public function updateStaffMember()
    {
        $request = $this->request;
        $socialArray = [];
        $memberData  = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, ['facebook', 'instagram', 'twitter', 'linkedin'])) {
                $socialArray[$key] = $value;
                continue;
            }

            $memberData[$key] = $value;
        }

        $memberData['socials'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        return AboutStaff::query()
            ->update($memberData)
            ->where($request->get('staffId'))
            ->exec()
        ;
    }

    /**
     * @return mixed
     */
    public function removeStaffMember()
    {
        $request = $this->request;
        return AboutStaff::query()->delete($request->get('staffId'));
    }

    /**
     * @return mixed
     */
    public function removeStaffMemberCategory()
    {
        $request = $this->request;
        $categoryId = $request->get('categoryId');
        AboutStaff::query()
            ->update(['staff_category_id' => 0])
            ->where('staff_category_id', $categoryId)
            ->exec()
        ;

        return AboutStaffCategory::query()->delete($request->get('categoryId'));
    }

    /**
     * @return int|string
     */
    public function addStaffMemberCategory()
    {
        $request = $this->request;
        return AboutStaffCategory::query()->insert([
            'name' => $request->get('name')
        ]);
    }

    /**
     * @return int|string
     */
    public function createStaffMember()
    {
        $request = $this->request;
        $socialArray = [];
        $memberData  = [];
        foreach ($request->get('values') as $key => $value) {
            if (in_array($key, ['facebook', 'instagram', 'twitter', 'linkedin'])) {
                $socialArray[$key] = $value;
                continue;
            }

            $memberData[$key] = $value;
        }

        $memberData['socials'] = json_encode($socialArray, JSON_UNESCAPED_SLASHES);

        return AboutStaff::query()->insert($memberData);
    }

    /**
     * @return mixed
     */
    public function updateStaffMemberCategory()
    {
        $request = $this->request;
        return AboutStaffCategory::query()
            ->update(['name' => $request->get('name')])
            ->where('id', (int) $request->get('categoryId'))
            ->exec()
        ;
    }
}