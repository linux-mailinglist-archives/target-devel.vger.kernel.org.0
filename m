Return-Path: <target-devel-owner@vger.kernel.org>
X-Original-To: lists+target-devel@lfdr.de
Delivered-To: lists+target-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121571B2DD2
	for <lists+target-devel@lfdr.de>; Tue, 21 Apr 2020 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgDURKH (ORCPT <rfc822;lists+target-devel@lfdr.de>);
        Tue, 21 Apr 2020 13:10:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgDURKG (ORCPT
        <rfc822;target-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587489002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVpYJdodsP+Or4R35r/etgu+d63MuiQVIZfqRXn6zKg=;
        b=HEcZilxPbytMcwEescZyOttxhstXyDt6gwYoXQU1cTH0SWS/9kCLSvhT64yvjtGnkO71S0
        N1MdBcYVIDiSl0z5pb8KK3LRC5x2OJ8/KSMFeUh6aVjpKzrulwiilejdn34g3+VwZE0cjk
        6GYPI72GqTvPXqeC9xBTUhCPp+1WjJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-QaYYhCSBMh6ZfpUpv0t1Ew-1; Tue, 21 Apr 2020 13:09:58 -0400
X-MC-Unique: QaYYhCSBMh6ZfpUpv0t1Ew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 673A51005510;
        Tue, 21 Apr 2020 17:09:57 +0000 (UTC)
Received: from [10.10.120.138] (ovpn-120-138.rdu2.redhat.com [10.10.120.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E1ED76E7A;
        Tue, 21 Apr 2020 17:09:51 +0000 (UTC)
Subject: Re: [RFC PATCH 02/12] target: separate acl name from port ids
To:     Bodo Stroesser <bstroesser@ts.fujitsu.com>, jsmart2021@gmail.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
References: <20200420191426.17055-1-mchristi@redhat.com>
 <20200420191426.17055-3-mchristi@redhat.com>
 <7d826111-e149-efc4-9efe-5b932942d961@ts.fujitsu.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E9F28DD.6020003@redhat.com>
Date:   Tue, 21 Apr 2020 12:09:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <7d826111-e149-efc4-9efe-5b932942d961@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: target-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <target-devel.vger.kernel.org>
X-Mailing-List: target-devel@vger.kernel.org

On 04/21/2020 09:49 AM, Bodo Stroesser wrote:
> I'm wondering, whether the 'format' element of the new t10_transport_id
> structure is useful:
> 
> - It is used for iSCSI only, but is a common field for all protocols.
> 
> - In iSCSI, if format is 0 then session_id is NULL, and if format is
>   not 0 then session_id is not NULL. So session_id can be used for the
>   same purpose.
> 
> - I think it is a bug that tcm_loop and vhost claim to run iSCSI
>   protocol, but don't deliver an ISID. They e.g. could use the "Random"
>   format for the ISID, which starts with byte 0x80 followed by 3 random
>   bytes and 2 further bytes denoting the session.
> 
> Removing the format element would of course mean to not add the "format"
> session attribute later. (The "session_id" attribute doesn't even check
> format, but uses session_id as argument to "%s" in snprintf even if it
> is NULL).

Yeah, I was just letting it print "NULL" like the other stat file we
have that prints out the isid.

I can just drop format and it will print out "" like the ACL file.

> 
> 
> On 04/20/20 21:14, Mike Christie wrote:
>> To handle features like PGRs in userspace we need the entire iniaitor
>> port id. For iscsi that is defined as the initiator name plus the
>> session identifier. The session id is hidden from users, because
>> its internal to the drivers, so this patch separates the acl name
>> from the SCSI port ids.
>>
>> This will then allow other drivers like SRP to use different values
>> like the port id or src address for the ACL, but then use the port
>> id for transport ID checks in target_core_fabric.c.
>>
>> This will also be used to export the initiator info in the session's
>> sysfs dir in the last patches, so tools like tcmu-runner can rebuild
>> its session state used when handling PGR commands.
>>
>> Signed-off-by: Mike Christie <mchristi@redhat.com>
>> ---
>>   drivers/infiniband/ulp/srpt/ib_srpt.c    | 13 +++--
>>   drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |  9 +++-
>>   drivers/scsi/qla2xxx/tcm_qla2xxx.c       |  8 ++-
>>   drivers/target/loopback/tcm_loop.c       | 24 ++++++++-
>>   drivers/target/sbp/sbp_target.c          |  9 +++-
>>   drivers/target/target_core_fabric_lib.c  | 87
>> ++++++++++++++++++++++++++++++++
>>   drivers/target/target_core_internal.h    |  1 +
>>   drivers/target/target_core_transport.c   | 22 +++++---
>>   drivers/target/tcm_fc/tfc_sess.c         | 10 +++-
>>   drivers/usb/gadget/function/f_tcm.c      | 11 +++-
>>   drivers/vhost/scsi.c                     | 25 +++++++--
>>   drivers/xen/xen-scsiback.c               | 28 ++++++++--
>>   include/target/target_core_base.h        | 24 +++++++++
>>   include/target/target_core_fabric.h      |  3 +-
>>   14 files changed, 245 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 9855274..caeb32e 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -2144,6 +2144,7 @@ static int srpt_cm_req_recv(struct srpt_device
>> *const sdev,
>>                   const char *src_addr)
>>   {
>>       struct srpt_port *sport = &sdev->port[port_num - 1];
>> +    struct t10_transport_id tpid;
>>       struct srpt_nexus *nexus;
>>       struct srp_login_rsp *rsp = NULL;
>>       struct srp_login_rej *rej = NULL;
>> @@ -2314,13 +2315,17 @@ static int srpt_cm_req_recv(struct srpt_device
>> *const sdev,
>>       tag_num = ch->rq_size;
>>       tag_size = 1; /* ib_srpt does not use se_sess->sess_cmd_map */
>>   +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = SCSI_PROTOCOL_SRP;
>> +    tpid.srp.port_id = i_port_id + 2;
>> +
>>       mutex_lock(&sport->port_guid_id.mutex);
>>       list_for_each_entry(stpg, &sport->port_guid_id.tpg_list, entry) {
>>           if (!IS_ERR_OR_NULL(ch->sess))
>>               break;
>>           ch->sess = target_setup_session(&stpg->tpg, tag_num,
>>                           tag_size, TARGET_PROT_NORMAL,
>> -                        ch->sess_name, ch, NULL);
>> +                        &tpid, ch->sess_name, ch, NULL);
>>       }
>>       mutex_unlock(&sport->port_guid_id.mutex);
>>   @@ -2329,14 +2334,14 @@ static int srpt_cm_req_recv(struct
>> srpt_device *const sdev,
>>           if (!IS_ERR_OR_NULL(ch->sess))
>>               break;
>>           ch->sess = target_setup_session(&stpg->tpg, tag_num,
>> -                    tag_size, TARGET_PROT_NORMAL, i_port_id,
>> -                    ch, NULL);
>> +                    tag_size, TARGET_PROT_NORMAL, &tpid,
>> +                    i_port_id, ch, NULL);
>>           if (!IS_ERR_OR_NULL(ch->sess))
>>               break;
>>           /* Retry without leading "0x" */
>>           ch->sess = target_setup_session(&stpg->tpg, tag_num,
>>                           tag_size, TARGET_PROT_NORMAL,
>> -                        i_port_id + 2, ch, NULL);
>> +                        &tpid, i_port_id + 2, ch, NULL);
>>       }
>>       mutex_unlock(&sport->port_gid_id.mutex);
>>   diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> index d9e94e8..dba9ec0 100644
>> --- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> +++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
>> @@ -2208,6 +2208,7 @@ static int ibmvscsis_make_nexus(struct
>> ibmvscsis_tport *tport)
>>   {
>>       char *name = tport->tport_name;
>>       struct ibmvscsis_nexus *nexus;
>> +    struct t10_transport_id tpid;
>>       struct scsi_info *vscsi = container_of(tport, struct scsi_info,
>> tport);
>>       int rc;
>>   @@ -2222,9 +2223,13 @@ static int ibmvscsis_make_nexus(struct
>> ibmvscsis_tport *tport)
>>           return -ENOMEM;
>>       }
>>   +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = SCSI_PROTOCOL_SRP;
>> +    tpid.srp.port_id = name;
>> +
>>       nexus->se_sess = target_setup_session(&tport->se_tpg, 0, 0,
>> -                          TARGET_PROT_NORMAL, name, nexus,
>> -                          NULL);
>> +                          TARGET_PROT_NORMAL, &tpid, name,
>> +                          nexus, NULL);
>>       if (IS_ERR(nexus->se_sess)) {
>>           rc = PTR_ERR(nexus->se_sess);
>>           goto transport_init_fail;
>> diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
>> b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
>> index abe7f79..42a4025 100644
>> --- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
>> +++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
>> @@ -1428,6 +1428,7 @@ static int tcm_qla2xxx_check_initiator_node_acl(
>>   {
>>       struct qla_hw_data *ha = vha->hw;
>>       struct tcm_qla2xxx_lport *lport;
>> +    struct t10_transport_id tpid;
>>       struct tcm_qla2xxx_tpg *tpg;
>>       struct se_session *se_sess;
>>       unsigned char port_name[36];
>> @@ -1454,13 +1455,18 @@ static int tcm_qla2xxx_check_initiator_node_acl(
>>        */
>>       memset(&port_name, 0, 36);
>>       snprintf(port_name, sizeof(port_name), "%8phC", fc_wwpn);
>> +
>> +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = SCSI_PROTOCOL_FCP;
>> +    tpid.fcp.port_name = port_name;
>> +
>>       /*
>>        * Locate our struct se_node_acl either from an explict NodeACL
>> created
>>        * via ConfigFS, or via running in TPG demo mode.
>>        */
>>       se_sess = target_setup_session(&tpg->se_tpg, num_tags,
>>                          sizeof(struct qla_tgt_cmd),
>> -                       TARGET_PROT_ALL, port_name,
>> +                       TARGET_PROT_ALL, &tpid, port_name,
>>                          qlat_sess, tcm_qla2xxx_session_cb);
>>       if (IS_ERR(se_sess))
>>           return PTR_ERR(se_sess);
>> diff --git a/drivers/target/loopback/tcm_loop.c
>> b/drivers/target/loopback/tcm_loop.c
>> index 3305b47..7593a53 100644
>> --- a/drivers/target/loopback/tcm_loop.c
>> +++ b/drivers/target/loopback/tcm_loop.c
>> @@ -725,10 +725,11 @@ static int tcm_loop_alloc_sess_cb(struct
>> se_portal_group *se_tpg,
>>     static int tcm_loop_make_nexus(
>>       struct tcm_loop_tpg *tl_tpg,
>> -    const char *name)
>> +    char *name)
>>   {
>>       struct tcm_loop_hba *tl_hba = tl_tpg->tl_hba;
>>       struct tcm_loop_nexus *tl_nexus;
>> +    struct t10_transport_id tpid;
>>       int ret;
>>         if (tl_tpg->tl_nexus) {
>> @@ -736,13 +737,32 @@ static int tcm_loop_make_nexus(
>>           return -EEXIST;
>>       }
>>   +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = tl_hba->tl_proto_id;
>> +
>> +    switch (tpid.proto) {
>> +    case SCSI_PROTOCOL_SAS:
>> +        tpid.sas.addr = name;
>> +        break;
>> +    case SCSI_PROTOCOL_FCP:
>> +        tpid.fcp.port_name = name;
>> +        break;
>> +    case SCSI_PROTOCOL_ISCSI:
>> +        /* we only support format=0 */
>> +        tpid.iscsi.name = name;
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>>       tl_nexus = kzalloc(sizeof(*tl_nexus), GFP_KERNEL);
>>       if (!tl_nexus)
>>           return -ENOMEM;
>>         tl_nexus->se_sess = target_setup_session(&tl_tpg->tl_se_tpg,
>> 0, 0,
>>                       TARGET_PROT_DIN_PASS | TARGET_PROT_DOUT_PASS,
>> -                    name, tl_nexus, tcm_loop_alloc_sess_cb);
>> +                    &tpid, name, tl_nexus,
>> +                    tcm_loop_alloc_sess_cb);
>>       if (IS_ERR(tl_nexus->se_sess)) {
>>           ret = PTR_ERR(tl_nexus->se_sess);
>>           kfree(tl_nexus);
>> diff --git a/drivers/target/sbp/sbp_target.c
>> b/drivers/target/sbp/sbp_target.c
>> index e4a9b9f..9a3121d 100644
>> --- a/drivers/target/sbp/sbp_target.c
>> +++ b/drivers/target/sbp/sbp_target.c
>> @@ -181,6 +181,7 @@ static struct sbp_session *sbp_session_create(
>>           struct sbp_tpg *tpg,
>>           u64 guid)
>>   {
>> +    struct t10_transport_id tpid;
>>       struct sbp_session *sess;
>>       int ret;
>>       char guid_str[17];
>> @@ -196,10 +197,14 @@ static struct sbp_session *sbp_session_create(
>>       INIT_DELAYED_WORK(&sess->maint_work, session_maintenance_work);
>>       sess->guid = guid;
>>   +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = SCSI_PROTOCOL_SBP;
>> +    tpid.sbp.name = guid_str;
>> +
>>       sess->se_sess = target_setup_session(&tpg->se_tpg, 128,
>>                            sizeof(struct sbp_target_request),
>> -                         TARGET_PROT_NORMAL, guid_str,
>> -                         sess, NULL);
>> +                         TARGET_PROT_NORMAL, &tpid,
>> +                         guid_str, sess, NULL);
>>       if (IS_ERR(sess->se_sess)) {
>>           pr_err("failed to init se_session\n");
>>           ret = PTR_ERR(sess->se_sess);
>> diff --git a/drivers/target/target_core_fabric_lib.c
>> b/drivers/target/target_core_fabric_lib.c
>> index 6b4b354..39b0e5e 100644
>> --- a/drivers/target/target_core_fabric_lib.c
>> +++ b/drivers/target/target_core_fabric_lib.c
>> @@ -421,3 +421,90 @@ const char
>> *target_parse_pr_out_transport_id(struct se_portal_group *tpg,
>>       *out_tid_len = 24;
>>       return buf + offset;
>>   }
>> +
>> +struct t10_transport_id *target_cp_transport_id(struct
>> t10_transport_id *src)
>> +{
>> +    struct t10_transport_id *dst;
>> +
>> +    dst = kzalloc(sizeof(*dst), GFP_KERNEL);
>> +    if (!dst)
>> +        return NULL;
>> +    dst->format = src->format;
>> +    dst->proto = src->proto;
>> +
>> +    switch (src->proto) {
>> +    case SCSI_PROTOCOL_FCP:
>> +        dst->fcp.port_name = kstrdup(src->fcp.port_name, GFP_KERNEL);
>> +        if (!dst->fcp.port_name)
>> +            goto free_tpid;
>> +        break;
>> +    case SCSI_PROTOCOL_SBP:
>> +        dst->sbp.name = kstrdup(src->sbp.name, GFP_KERNEL);
>> +        if (!dst->sbp.name)
>> +            goto free_tpid;
>> +        break;
>> +    case SCSI_PROTOCOL_SRP:
>> +        dst->srp.port_id = kstrdup(src->srp.port_id, GFP_KERNEL);
>> +        if (!dst->srp.port_id)
>> +            goto free_tpid;
>> +        break;
>> +    case SCSI_PROTOCOL_SAS:
>> +        dst->sas.addr = kstrdup(src->sas.addr, GFP_KERNEL);
>> +        if (!dst->sas.addr)
>> +            goto free_tpid;
>> +        break;
>> +    case SCSI_PROTOCOL_ISCSI:
>> +        dst->iscsi.name = kstrdup(src->iscsi.name, GFP_KERNEL);
>> +        if (!dst->iscsi.name)
>> +            goto free_tpid;
>> +
>> +        if (src->format) {
>> +            dst->iscsi.session_id = kstrdup(src->iscsi.session_id,
>> +                            GFP_KERNEL);
>> +            if (!dst->iscsi.session_id) {
>> +                kfree(dst->iscsi.name);
>> +                goto free_tpid;
>> +            }
>> +        }
>> +        break;
>> +    default:
>> +        pr_err("Unknown proto_id: 0x%02x\n", src->proto);
>> +        return NULL;
>> +    }
>> +
>> +    return dst;
>> +
>> +free_tpid:
>> +    kfree(dst);
>> +    return NULL;
>> +}
>> +EXPORT_SYMBOL(target_cp_transport_id);
>> +
>> +void target_free_transport_id(struct t10_transport_id *tpid)
>> +{
>> +    if (!tpid)
>> +        return;
>> +
>> +    switch (tpid->proto) {
>> +    case SCSI_PROTOCOL_FCP:
>> +        kfree(tpid->fcp.port_name);
>> +        break;
>> +    case SCSI_PROTOCOL_SBP:
>> +        kfree(tpid->sbp.name);
>> +        break;
>> +    case SCSI_PROTOCOL_SRP:
>> +        kfree(tpid->srp.port_id);
>> +        break;
>> +    case SCSI_PROTOCOL_SAS:
>> +        kfree(tpid->sas.addr);
>> +        break;
>> +    case SCSI_PROTOCOL_ISCSI:
>> +        kfree(tpid->iscsi.name);
>> +        kfree(tpid->iscsi.session_id);
>> +        break;
>> +    default:
>> +        pr_err("Unknown proto_id: 0x%02x\n", tpid->proto);
>> +        return;
>> +    }
>> +    kfree(tpid);
>> +}
>> diff --git a/drivers/target/target_core_internal.h
>> b/drivers/target/target_core_internal.h
>> index 8533444..5e016aa 100644
>> --- a/drivers/target/target_core_internal.h
>> +++ b/drivers/target/target_core_internal.h
>> @@ -104,6 +104,7 @@ int    target_get_pr_transport_id(struct
>> se_node_acl *nacl,
>>           unsigned char *buf);
>>   const char *target_parse_pr_out_transport_id(struct se_portal_group
>> *tpg,
>>           char *buf, u32 *out_tid_len, char **port_nexus_ptr);
>> +void target_free_transport_id(struct t10_transport_id *tpid);
>>     /* target_core_hba.c */
>>   struct se_hba *core_alloc_hba(const char *, u32, u32);
>> diff --git a/drivers/target/target_core_transport.c
>> b/drivers/target/target_core_transport.c
>> index 0ae9e60..adf4a84 100644
>> --- a/drivers/target/target_core_transport.c
>> +++ b/drivers/target/target_core_transport.c
>> @@ -416,12 +416,13 @@ void transport_register_session(
>>   struct se_session *
>>   target_setup_session(struct se_portal_group *tpg,
>>                unsigned int tag_num, unsigned int tag_size,
>> -             enum target_prot_op prot_op,
>> +             enum target_prot_op prot_op, struct t10_transport_id *tpid,
>>                const char *initiatorname, void *private,
>>                int (*callback)(struct se_portal_group *,
>>                        struct se_session *, void *))
>>   {
>>       struct se_session *sess;
>> +    int rc;
>>         /*
>>        * If the fabric driver is using percpu-ida based pre allocation
>> @@ -435,6 +436,12 @@ struct se_session *
>>       if (IS_ERR(sess))
>>           return sess;
>>   +    sess->tpid = target_cp_transport_id(tpid);
>> +    if (!sess->tpid) {
>> +        rc = -ENOMEM;
>> +        goto free_sess;
>> +    }
>> +
>>       sess->se_node_acl = core_tpg_check_initiator_node_acl(tpg,
>>                       (unsigned char *)initiatorname);
>>       if (!sess->se_node_acl) {
>> @@ -446,15 +453,17 @@ struct se_session *
>>        * required before transport_register_session().
>>        */
>>       if (callback != NULL) {
>> -        int rc = callback(tpg, sess, private);
>> -        if (rc) {
>> -            transport_free_session(sess);
>> -            return ERR_PTR(rc);
>> -        }
>> +        rc = callback(tpg, sess, private);
>> +        if (rc)
>> +            goto free_sess;
>>       }
>>         transport_register_session(tpg, sess->se_node_acl, sess,
>> private);
>>       return sess;
>> +
>> +free_sess:
>> +    transport_free_session(sess);
>> +    return ERR_PTR(rc);
>>   }
>>   EXPORT_SYMBOL(target_setup_session);
>>   @@ -579,6 +588,7 @@ void transport_free_session(struct se_session
>> *se_sess)
>>           sbitmap_queue_free(&se_sess->sess_tag_pool);
>>           kvfree(se_sess->sess_cmd_map);
>>       }
>> +    target_free_transport_id(se_sess->tpid);
>>       percpu_ref_exit(&se_sess->cmd_count);
>>       kmem_cache_free(se_sess_cache, se_sess);
>>   }
>> diff --git a/drivers/target/tcm_fc/tfc_sess.c
>> b/drivers/target/tcm_fc/tfc_sess.c
>> index 4fd6a1d..f261756 100644
>> --- a/drivers/target/tcm_fc/tfc_sess.c
>> +++ b/drivers/target/tcm_fc/tfc_sess.c
>> @@ -208,6 +208,7 @@ static struct ft_sess *ft_sess_create(struct
>> ft_tport *tport, u32 port_id,
>>                         struct fc_rport_priv *rdata)
>>   {
>>       struct se_portal_group *se_tpg = &tport->tpg->se_tpg;
>> +    struct t10_transport_id tpid;
>>       struct ft_sess *sess;
>>       struct hlist_head *head;
>>       unsigned char initiatorname[TRANSPORT_IQN_LEN];
>> @@ -227,10 +228,15 @@ static struct ft_sess *ft_sess_create(struct
>> ft_tport *tport, u32 port_id,
>>       sess->tport = tport;
>>       sess->port_id = port_id;
>>   +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = SCSI_PROTOCOL_FCP;
>> +    tpid.fcp.port_name = &initiatorname[0];
>> +
>>       sess->se_sess = target_setup_session(se_tpg, TCM_FC_DEFAULT_TAGS,
>>                            sizeof(struct ft_cmd),
>> -                         TARGET_PROT_NORMAL, &initiatorname[0],
>> -                         sess, ft_sess_alloc_cb);
>> +                         TARGET_PROT_NORMAL, &tpid,
>> +                         &initiatorname[0], sess,
>> +                         ft_sess_alloc_cb);
>>       if (IS_ERR(sess->se_sess)) {
>>           int rc = PTR_ERR(sess->se_sess);
>>           kfree(sess);
>> diff --git a/drivers/usb/gadget/function/f_tcm.c
>> b/drivers/usb/gadget/function/f_tcm.c
>> index 3650493..e282eb9 100644
>> --- a/drivers/usb/gadget/function/f_tcm.c
>> +++ b/drivers/usb/gadget/function/f_tcm.c
>> @@ -1564,6 +1564,7 @@ static int usbg_alloc_sess_cb(struct
>> se_portal_group *se_tpg,
>>   static int tcm_usbg_make_nexus(struct usbg_tpg *tpg, char *name)
>>   {
>>       struct tcm_usbg_nexus *tv_nexus;
>> +    struct t10_transport_id tpid;
>>       int ret = 0;
>>         mutex_lock(&tpg->tpg_mutex);
>> @@ -1579,11 +1580,17 @@ static int tcm_usbg_make_nexus(struct usbg_tpg
>> *tpg, char *name)
>>           goto out_unlock;
>>       }
>>   +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = tpg->se_tpg.proto_id;
>> +    /* SPC does not assign a proto id for USB-SCSI so we use SAS
>> naming */
>> +    tpid.sas.addr = name;
>> +
>>       tv_nexus->tvn_se_sess = target_setup_session(&tpg->se_tpg,
>>                                USB_G_DEFAULT_SESSION_TAGS,
>>                                sizeof(struct usbg_cmd),
>> -                             TARGET_PROT_NORMAL, name,
>> -                             tv_nexus, usbg_alloc_sess_cb);
>> +                             TARGET_PROT_NORMAL, &tpid,
>> +                             name, tv_nexus,
>> +                             usbg_alloc_sess_cb);
>>       if (IS_ERR(tv_nexus->tvn_se_sess)) {
>>   #define MAKE_NEXUS_MSG "core_tpg_check_initiator_node_acl() failed
>> for %s\n"
>>           pr_debug(MAKE_NEXUS_MSG, name);
>> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> index 0b949a1..bc377ee 100644
>> --- a/drivers/vhost/scsi.c
>> +++ b/drivers/vhost/scsi.c
>> @@ -1937,10 +1937,10 @@ static int vhost_scsi_nexus_cb(struct
>> se_portal_group *se_tpg,
>>       return -ENOMEM;
>>   }
>>   -static int vhost_scsi_make_nexus(struct vhost_scsi_tpg *tpg,
>> -                const char *name)
>> +static int vhost_scsi_make_nexus(struct vhost_scsi_tpg *tpg, char *name)
>>   {
>>       struct vhost_scsi_nexus *tv_nexus;
>> +    struct t10_transport_id tpid;
>>         mutex_lock(&tpg->tv_tpg_mutex);
>>       if (tpg->tpg_nexus) {
>> @@ -1949,6 +1949,25 @@ static int vhost_scsi_make_nexus(struct
>> vhost_scsi_tpg *tpg,
>>           return -EEXIST;
>>       }
>>   +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = tpg->se_tpg.proto_id;
>> +
>> +    switch (tpid.proto) {
>> +    case SCSI_PROTOCOL_SAS:
>> +        tpid.sas.addr = name;
>> +        break;
>> +    case SCSI_PROTOCOL_FCP:
>> +        tpid.fcp.port_name = name;
>> +        break;
>> +    case SCSI_PROTOCOL_ISCSI:
>> +        /* we only support format=0 */
>> +        tpid.iscsi.name = name;
>> +        break;
>> +    default:
>> +        mutex_unlock(&tpg->tv_tpg_mutex);
>> +        return -EINVAL;
>> +    }
>> +
>>       tv_nexus = kzalloc(sizeof(*tv_nexus), GFP_KERNEL);
>>       if (!tv_nexus) {
>>           mutex_unlock(&tpg->tv_tpg_mutex);
>> @@ -1964,7 +1983,7 @@ static int vhost_scsi_make_nexus(struct
>> vhost_scsi_tpg *tpg,
>>                       VHOST_SCSI_DEFAULT_TAGS,
>>                       sizeof(struct vhost_scsi_cmd),
>>                       TARGET_PROT_DIN_PASS | TARGET_PROT_DOUT_PASS,
>> -                    (unsigned char *)name, tv_nexus,
>> +                    &tpid, (unsigned char *)name, tv_nexus,
>>                       vhost_scsi_nexus_cb);
>>       if (IS_ERR(tv_nexus->tvn_se_sess)) {
>>           mutex_unlock(&tpg->tv_tpg_mutex);
>> diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
>> index ba0942e..0855a77f 100644
>> --- a/drivers/xen/xen-scsiback.c
>> +++ b/drivers/xen/xen-scsiback.c
>> @@ -1507,10 +1507,10 @@ static int scsiback_alloc_sess_cb(struct
>> se_portal_group *se_tpg,
>>       return 0;
>>   }
>>   -static int scsiback_make_nexus(struct scsiback_tpg *tpg,
>> -                const char *name)
>> +static int scsiback_make_nexus(struct scsiback_tpg *tpg, char *name)
>>   {
>>       struct scsiback_nexus *tv_nexus;
>> +    struct t10_transport_id tpid;
>>       int ret = 0;
>>         mutex_lock(&tpg->tv_tpg_mutex);
>> @@ -1520,6 +1520,25 @@ static int scsiback_make_nexus(struct
>> scsiback_tpg *tpg,
>>           goto out_unlock;
>>       }
>>   +    memset(&tpid, 0, sizeof(tpid));
>> +    tpid.proto = tpg->se_tpg.proto_id;
>> +
>> +    switch (tpid.proto) {
>> +    case SCSI_PROTOCOL_SAS:
>> +        tpid.sas.addr = name;
>> +        break;
>> +    case SCSI_PROTOCOL_FCP:
>> +        tpid.fcp.port_name = name;
>> +        break;
>> +    case SCSI_PROTOCOL_ISCSI:
>> +        /* we only support format=0 */
>> +        tpid.iscsi.name = name;
>> +        break;
>> +    default:
>> +        ret =-EINVAL;
>> +        goto out_unlock;
>> +    }
>> +
>>       tv_nexus = kzalloc(sizeof(struct scsiback_nexus), GFP_KERNEL);
>>       if (!tv_nexus) {
>>           ret = -ENOMEM;
>> @@ -1529,8 +1548,9 @@ static int scsiback_make_nexus(struct
>> scsiback_tpg *tpg,
>>       tv_nexus->tvn_se_sess = target_setup_session(&tpg->se_tpg,
>>                                VSCSI_DEFAULT_SESSION_TAGS,
>>                                sizeof(struct vscsibk_pend),
>> -                             TARGET_PROT_NORMAL, name,
>> -                             tv_nexus, scsiback_alloc_sess_cb);
>> +                             TARGET_PROT_NORMAL, &tpid,
>> +                             name, tv_nexus,
>> +                             scsiback_alloc_sess_cb);
>>       if (IS_ERR(tv_nexus->tvn_se_sess)) {
>>           kfree(tv_nexus);
>>           ret = -ENOMEM;
>> diff --git a/include/target/target_core_base.h
>> b/include/target/target_core_base.h
>> index 1728e88..cd440ea 100644
>> --- a/include/target/target_core_base.h
>> +++ b/include/target/target_core_base.h
>> @@ -333,6 +333,29 @@ struct t10_wwn {
>>       struct list_head t10_vpd_list;
>>   };
>>   +struct t10_transport_id {
>> +    union {
>> +        struct {
>> +            char *port_name;
>> +        } fcp;
>> +        struct {
>> +            char *addr;
>> +        } sas;
>> +        struct {
>> +            char *name;
>> +        } sbp;
>> +        struct {
>> +            char *port_id;
>> +        } srp;
>> +        struct {
>> +            char *name;
>> +            char *session_id;
>> +        } iscsi;
>> +    };
>> +    u8 format;
>> +    u8 proto;
>> +};
>> +
>>   struct t10_pr_registration {
>>       /* Used for fabrics that contain WWN+ISID */
>>   #define PR_REG_ISID_LEN                16
>> @@ -605,6 +628,7 @@ static inline struct se_node_acl
>> *fabric_stat_to_nacl(struct config_item *item)
>>   struct se_session {
>>       unsigned        sess_tearing_down:1;
>>       u64            sess_bin_isid;
>> +    struct t10_transport_id    *tpid;
>>       enum target_prot_op    sup_prot_ops;
>>       enum target_prot_type    sess_prot_type;
>>       struct se_node_acl    *se_node_acl;
>> diff --git a/include/target/target_core_fabric.h
>> b/include/target/target_core_fabric.h
>> index 063f133..6b8a6bc 100644
>> --- a/include/target/target_core_fabric.h
>> +++ b/include/target/target_core_fabric.h
>> @@ -125,9 +125,10 @@ struct target_core_fabric_ops {
>>   int target_depend_item(struct config_item *item);
>>   void target_undepend_item(struct config_item *item);
>>   +struct t10_transport_id *target_cp_transport_id(struct
>> t10_transport_id *);
>>   struct se_session *target_setup_session(struct se_portal_group *,
>>           unsigned int, unsigned int, enum target_prot_op prot_op,
>> -        const char *, void *,
>> +        struct t10_transport_id *, const char *, void *,
>>           int (*callback)(struct se_portal_group *,
>>                   struct se_session *, void *));
>>   void target_remove_session(struct se_session *);
>>
> 

